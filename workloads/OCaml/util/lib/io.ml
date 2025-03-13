open Runner
open Crowbar
open Parse

(* global timeout in seconds for test threads *)
let timeout = ref 60

let brun (p : 'a property) (g : 'a basegen) (s : string) : unit = p.b g p.name s ()

let bmain seed oc t ts s ss =
  let t' = lookup ts t in
  let s' = lookup ss s in
  match (t', s') with
  | None, _ -> Printf.printf "Test %s not found\n" t
  | _, None -> Printf.printf "Strategy %s not found\n" s
  | Some t', Some s' ->
      let start_time = Unix.gettimeofday () in
      brun t' s' seed;
      let end_time = Unix.gettimeofday () in
      Printf.fprintf oc "[%f start %s]\n" start_time seed;
      Printf.fprintf oc "[%f end %s]\n" end_time seed;
      flush oc
  
(* piping helper functions *)



  let _simple_fork f file =
    Printf.printf "Timeout value: %d seconds\n" !timeout; (* Debugging timeout value *)
    let oc = open_out_gen [ Open_wronly; Open_append; Open_creat ] 0o666 file in
    match Unix.fork () with
    (* runner/child thread *)
    | 0 ->
        f oc
        (* todo: if the forking overhead is too much, we could pipe the endtime back to the main thread *)
    | pid -> (
        match Unix.fork () with
        | 0 ->
            (* timeout thread *)
            Unix.sleep !timeout;
            Unix.kill pid Sys.sigalrm
        | pid' -> (
            (* waiting thread *)
            let _, status = Unix.waitpid [] pid in
            let endtime = Unix.gettimeofday () in
            Unix.kill pid' Sys.sigterm;
            match status with
            | Unix.WEXITED _ -> 
              Printf.fprintf oc "[%f exit ok]\n" endtime
            | Unix.WSIGNALED c when c = Sys.sigalrm ->
                Printf.fprintf oc "[%f exit timeout]\n" endtime
            | _ -> Printf.fprintf oc "[%f exit unexpected]\n" endtime))
  
let base_fork seed t ts s ss = _simple_fork (fun oc ->
  bmain seed oc t ts s ss)

(* Call format:
   dune exec <workload> -- <framework> <testname> <strategy> <filename>
   for example,
   dune exec BST -- qcheck prop_InsertValid bespokeGenerator out.txt
   or
   dune exec BST -- crowbar prop_InsertPost crowbarType out2.txt
*)
let main (props : (string * 'a property) list)
     
    (bstrats : (string * 'a basegen) list) : unit =
  if Array.length Sys.argv < 5 then
    match Unix.getenv "framework" with
    | _ ->
        print_endline
          "Not enough arguments were passed. Could not determine whether this \
           was a child process."
  else
    let framework = Sys.argv.(1) in
    let testname = Sys.argv.(2) in
    let strategy = Sys.argv.(3) in
    let filename = Sys.argv.(4) in
    let seed = Sys.argv.(5) in
    Printf.printf
      "Executing test %s into file %s using strategy %s on framework %s, with seed %s\n"
      testname filename strategy framework seed;
    flush stdout;
    match framework with
    | "base" ->
        print_endline "Valid framework Base_quickcheck\n";
        base_fork seed testname props strategy bstrats filename
    | _ -> print_endline ("Framework " ^ framework ^ " was not found\n")

let etna = main