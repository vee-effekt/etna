open Type;;
open Fast_gen;;
open Core;;

module C_SR = Fast_gen.Staged_generator.MakeStaged(Fast_gen.C_sr_dropin_random)

module BaseTypCsr : Base_quickcheck.Test.S with type t = rbt = struct
  type t = rbt [@@deriving sexp, quickcheck]
  let quickcheck_generator =
    Base_quickcheck.Generator.create
      (fun ~size:size_113 ->
        fun ~random:random_114 ->
          let t_115 = Obj.magic 0 in
          let t_224 =
            let rec go_116 x_117 ~size:size_118  ~random:random_119  =
              if size_118 = 0
              then
                let t_220 = 0. +. 1. in
                let t_221 =
                  if (Base.Float.compare 0. t_220) > 0
                  then Stdlib.failwith "Crossed bounds!"
                  else
                    if
                      Stdlib.not
                        ((Stdlib.Float.is_finite 0.) &&
                            (Stdlib.Float.is_finite t_220))
                    then Stdlib.failwith "Infite floats"
                    else
                      Fast_gen.C_sr_dropin_random_runtime.float_c_unchecked
                        random_119 0. t_220 in
                let t_222 = (Stdlib.Float.compare t_221 1.) <= 0 in
                (if t_222
                  then E
                  else
                    (let t_223 = t_221 -. 1. in
                    Stdlib.failwith "Fell of the end of pick list"))
              else
                (let t_120 = 0. +. 1. in
                  let t_121 = t_120 +. 1. in
                  let t_122 =
                    if (Base.Float.compare 0. t_121) > 0
                    then Stdlib.failwith "Crossed bounds!"
                    else
                      if
                        Stdlib.not
                          ((Stdlib.Float.is_finite 0.) &&
                            (Stdlib.Float.is_finite t_121))
                      then Stdlib.failwith "Infite floats"
                      else
                        Fast_gen.C_sr_dropin_random_runtime.float_c_unchecked
                          random_119 0. t_121 in
                  let t_123 = (Stdlib.Float.compare t_122 1.) <= 0 in
                  if t_123
                  then E
                  else
                    (let t_124 = t_122 -. 1. in
                    let t_125 = (Stdlib.Float.compare t_124 1.) <= 0 in
                    if t_125
                    then
                      let t_127 =
                        go_116 (Obj.magic 0) ~size:(size_118 - 1)
                          ~random:random_119 in
                      let t_128 =
                        Fast_gen.C_sr_dropin_random_runtime.bool_c random_119 in
                      let t_129 =
                        Fast_gen.C_sr_dropin_random_runtime.float_c_unchecked
                          random_119 0. 1.0 in
                      let t_130 = (Stdlib.Float.compare t_129 0.05) <= 0 in
                      (if t_130
                        then
                          let t_191 =
                            Fast_gen.C_sr_dropin_random_runtime.bool_c random_119 in
                          let t_192 =
                            Fast_gen.C_sr_dropin_random_runtime.float_c_unchecked
                              random_119 0. 1.0 in
                          let t_193 = (Stdlib.Float.compare t_192 0.05) <= 0 in
                          (if t_193
                          then
                            let t_212 =
                              go_116 (Obj.magic 0) ~size:(size_118 - 1)
                                ~random:random_119 in
                            let t_213 = 0. +. 1. in
                            let t_214 = t_213 +. 1. in
                            let t_215 =
                              if (Base.Float.compare 0. t_214) > 0
                              then Stdlib.failwith "Crossed bounds!"
                              else
                                if
                                  Stdlib.not
                                    ((Stdlib.Float.is_finite 0.) &&
                                        (Stdlib.Float.is_finite t_214))
                                then Stdlib.failwith "Infite floats"
                                else
                                  Fast_gen.C_sr_dropin_random_runtime.float_c_unchecked
                                    random_119 0. t_214 in
                            let t_216 = (Stdlib.Float.compare t_215 1.) <= 0 in
                            (if t_216
                              then
                                T
                                  (R, t_212,
                                    (0 lxor (- (Base.Bool.to_int t_191))),
                                    (0 lxor (- (Base.Bool.to_int t_128))), t_127)
                              else
                                (let t_217 = t_215 -. 1. in
                                let t_218 = (Stdlib.Float.compare t_217 1.) <= 0 in
                                if t_218
                                then
                                  T
                                    (B, t_212,
                                      (0 lxor (- (Base.Bool.to_int t_191))),
                                      (0 lxor (- (Base.Bool.to_int t_128))),
                                      t_127)
                                else
                                  (let t_219 = t_217 -. 1. in
                                    Stdlib.failwith
                                      "Fell of the end of pick list")))
                          else
                            (let t_194 = (Stdlib.Float.compare t_192 0.1) <= 0 in
                              if t_194
                              then
                                let t_204 =
                                  go_116 (Obj.magic 0) ~size:(size_118 - 1)
                                    ~random:random_119 in
                                let t_205 = 0. +. 1. in
                                let t_206 = t_205 +. 1. in
                                let t_207 =
                                  if (Base.Float.compare 0. t_206) > 0
                                  then Stdlib.failwith "Crossed bounds!"
                                  else
                                    if
                                      Stdlib.not
                                        ((Stdlib.Float.is_finite 0.) &&
                                          (Stdlib.Float.is_finite t_206))
                                    then Stdlib.failwith "Infite floats"
                                    else
                                      Fast_gen.C_sr_dropin_random_runtime.float_c_unchecked
                                        random_119 0. t_206 in
                                let t_208 = (Stdlib.Float.compare t_207 1.) <= 0 in
                                (if t_208
                                then
                                  T
                                    (R, t_204,
                                      (1000 lxor
                                          (- (Base.Bool.to_int t_191))),
                                      (0 lxor (- (Base.Bool.to_int t_128))),
                                      t_127)
                                else
                                  (let t_209 = t_207 -. 1. in
                                    let t_210 =
                                      (Stdlib.Float.compare t_209 1.) <= 0 in
                                    if t_210
                                    then
                                      T
                                        (B, t_204,
                                          (1000 lxor
                                            (- (Base.Bool.to_int t_191))),
                                          (0 lxor (- (Base.Bool.to_int t_128))),
                                          t_127)
                                    else
                                      (let t_211 = t_209 -. 1. in
                                      Stdlib.failwith
                                        "Fell of the end of pick list")))
                              else
                                (let t_195 =
                                  Fast_gen.C_sr_dropin_random_runtime.int_c_log_uniform
                                    random_119 0 1000 in
                                let t_196 =
                                  go_116 (Obj.magic 0) ~size:(size_118 - 1)
                                    ~random:random_119 in
                                let t_197 = 0. +. 1. in
                                let t_198 = t_197 +. 1. in
                                let t_199 =
                                  if (Base.Float.compare 0. t_198) > 0
                                  then Stdlib.failwith "Crossed bounds!"
                                  else
                                    if
                                      Stdlib.not
                                        ((Stdlib.Float.is_finite 0.) &&
                                            (Stdlib.Float.is_finite t_198))
                                    then Stdlib.failwith "Infite floats"
                                    else
                                      Fast_gen.C_sr_dropin_random_runtime.float_c_unchecked
                                        random_119 0. t_198 in
                                let t_200 = (Stdlib.Float.compare t_199 1.) <= 0 in
                                if t_200
                                then
                                  T
                                    (R, t_196,
                                      (t_195 lxor (- (Base.Bool.to_int t_191))),
                                      (0 lxor (- (Base.Bool.to_int t_128))),
                                      t_127)
                                else
                                  (let t_201 = t_199 -. 1. in
                                    let t_202 =
                                      (Stdlib.Float.compare t_201 1.) <= 0 in
                                    if t_202
                                    then
                                      T
                                        (B, t_196,
                                          (t_195 lxor
                                            (- (Base.Bool.to_int t_191))),
                                          (0 lxor (- (Base.Bool.to_int t_128))),
                                          t_127)
                                    else
                                      (let t_203 = t_201 -. 1. in
                                      Stdlib.failwith
                                        "Fell of the end of pick list")))))
                        else
                          (let t_131 = (Stdlib.Float.compare t_129 0.1) <= 0 in
                          if t_131
                          then
                            let t_162 =
                              Fast_gen.C_sr_dropin_random_runtime.bool_c
                                random_119 in
                            let t_163 =
                              Fast_gen.C_sr_dropin_random_runtime.float_c_unchecked
                                random_119 0. 1.0 in
                            let t_164 = (Stdlib.Float.compare t_163 0.05) <= 0 in
                            (if t_164
                              then
                                let t_183 =
                                  go_116 (Obj.magic 0) ~size:(size_118 - 1)
                                    ~random:random_119 in
                                let t_184 = 0. +. 1. in
                                let t_185 = t_184 +. 1. in
                                let t_186 =
                                  if (Base.Float.compare 0. t_185) > 0
                                  then Stdlib.failwith "Crossed bounds!"
                                  else
                                    if
                                      Stdlib.not
                                        ((Stdlib.Float.is_finite 0.) &&
                                          (Stdlib.Float.is_finite t_185))
                                    then Stdlib.failwith "Infite floats"
                                    else
                                      Fast_gen.C_sr_dropin_random_runtime.float_c_unchecked
                                        random_119 0. t_185 in
                                let t_187 = (Stdlib.Float.compare t_186 1.) <= 0 in
                                (if t_187
                                then
                                  T
                                    (R, t_183,
                                      (0 lxor (- (Base.Bool.to_int t_162))),
                                      (1000 lxor
                                          (- (Base.Bool.to_int t_128))), t_127)
                                else
                                  (let t_188 = t_186 -. 1. in
                                    let t_189 =
                                      (Stdlib.Float.compare t_188 1.) <= 0 in
                                    if t_189
                                    then
                                      T
                                        (B, t_183,
                                          (0 lxor (- (Base.Bool.to_int t_162))),
                                          (1000 lxor
                                            (- (Base.Bool.to_int t_128))),
                                          t_127)
                                    else
                                      (let t_190 = t_188 -. 1. in
                                      Stdlib.failwith
                                        "Fell of the end of pick list")))
                              else
                                (let t_165 =
                                  (Stdlib.Float.compare t_163 0.1) <= 0 in
                                if t_165
                                then
                                  let t_175 =
                                    go_116 (Obj.magic 0) ~size:(size_118 - 1)
                                      ~random:random_119 in
                                  let t_176 = 0. +. 1. in
                                  let t_177 = t_176 +. 1. in
                                  let t_178 =
                                    if (Base.Float.compare 0. t_177) > 0
                                    then Stdlib.failwith "Crossed bounds!"
                                    else
                                      if
                                        Stdlib.not
                                          ((Stdlib.Float.is_finite 0.) &&
                                              (Stdlib.Float.is_finite t_177))
                                      then Stdlib.failwith "Infite floats"
                                      else
                                        Fast_gen.C_sr_dropin_random_runtime.float_c_unchecked
                                          random_119 0. t_177 in
                                  let t_179 =
                                    (Stdlib.Float.compare t_178 1.) <= 0 in
                                  (if t_179
                                    then
                                      T
                                        (R, t_175,
                                          (1000 lxor
                                            (- (Base.Bool.to_int t_162))),
                                          (1000 lxor
                                            (- (Base.Bool.to_int t_128))),
                                          t_127)
                                    else
                                      (let t_180 = t_178 -. 1. in
                                      let t_181 =
                                        (Stdlib.Float.compare t_180 1.) <= 0 in
                                      if t_181
                                      then
                                        T
                                          (B, t_175,
                                            (1000 lxor
                                                (- (Base.Bool.to_int t_162))),
                                            (1000 lxor
                                                (- (Base.Bool.to_int t_128))),
                                            t_127)
                                      else
                                        (let t_182 = t_180 -. 1. in
                                          Stdlib.failwith
                                            "Fell of the end of pick list")))
                                else
                                  (let t_166 =
                                      Fast_gen.C_sr_dropin_random_runtime.int_c_log_uniform
                                        random_119 0 1000 in
                                    let t_167 =
                                      go_116 (Obj.magic 0) ~size:(size_118 - 1)
                                        ~random:random_119 in
                                    let t_168 = 0. +. 1. in
                                    let t_169 = t_168 +. 1. in
                                    let t_170 =
                                      if (Base.Float.compare 0. t_169) > 0
                                      then Stdlib.failwith "Crossed bounds!"
                                      else
                                        if
                                          Stdlib.not
                                            ((Stdlib.Float.is_finite 0.) &&
                                              (Stdlib.Float.is_finite t_169))
                                        then Stdlib.failwith "Infite floats"
                                        else
                                          Fast_gen.C_sr_dropin_random_runtime.float_c_unchecked
                                            random_119 0. t_169 in
                                    let t_171 =
                                      (Stdlib.Float.compare t_170 1.) <= 0 in
                                    if t_171
                                    then
                                      T
                                        (R, t_167,
                                          (t_166 lxor
                                            (- (Base.Bool.to_int t_162))),
                                          (1000 lxor
                                            (- (Base.Bool.to_int t_128))),
                                          t_127)
                                    else
                                      (let t_172 = t_170 -. 1. in
                                      let t_173 =
                                        (Stdlib.Float.compare t_172 1.) <= 0 in
                                      if t_173
                                      then
                                        T
                                          (B, t_167,
                                            (t_166 lxor
                                                (- (Base.Bool.to_int t_162))),
                                            (1000 lxor
                                                (- (Base.Bool.to_int t_128))),
                                            t_127)
                                      else
                                        (let t_174 = t_172 -. 1. in
                                          Stdlib.failwith
                                            "Fell of the end of pick list")))))
                          else
                            (let t_132 =
                                Fast_gen.C_sr_dropin_random_runtime.int_c_log_uniform
                                  random_119 0 1000 in
                              let t_133 =
                                Fast_gen.C_sr_dropin_random_runtime.bool_c
                                  random_119 in
                              let t_134 =
                                Fast_gen.C_sr_dropin_random_runtime.float_c_unchecked
                                  random_119 0. 1.0 in
                              let t_135 = (Stdlib.Float.compare t_134 0.05) <= 0 in
                              if t_135
                              then
                                let t_154 =
                                  go_116 (Obj.magic 0) ~size:(size_118 - 1)
                                    ~random:random_119 in
                                let t_155 = 0. +. 1. in
                                let t_156 = t_155 +. 1. in
                                let t_157 =
                                  if (Base.Float.compare 0. t_156) > 0
                                  then Stdlib.failwith "Crossed bounds!"
                                  else
                                    if
                                      Stdlib.not
                                        ((Stdlib.Float.is_finite 0.) &&
                                          (Stdlib.Float.is_finite t_156))
                                    then Stdlib.failwith "Infite floats"
                                    else
                                      Fast_gen.C_sr_dropin_random_runtime.float_c_unchecked
                                        random_119 0. t_156 in
                                let t_158 = (Stdlib.Float.compare t_157 1.) <= 0 in
                                (if t_158
                                then
                                  T
                                    (R, t_154,
                                      (0 lxor (- (Base.Bool.to_int t_133))),
                                      (t_132 lxor (- (Base.Bool.to_int t_128))),
                                      t_127)
                                else
                                  (let t_159 = t_157 -. 1. in
                                    let t_160 =
                                      (Stdlib.Float.compare t_159 1.) <= 0 in
                                    if t_160
                                    then
                                      T
                                        (B, t_154,
                                          (0 lxor (- (Base.Bool.to_int t_133))),
                                          (t_132 lxor
                                            (- (Base.Bool.to_int t_128))),
                                          t_127)
                                    else
                                      (let t_161 = t_159 -. 1. in
                                      Stdlib.failwith
                                        "Fell of the end of pick list")))
                              else
                                (let t_136 =
                                  (Stdlib.Float.compare t_134 0.1) <= 0 in
                                if t_136
                                then
                                  let t_146 =
                                    go_116 (Obj.magic 0) ~size:(size_118 - 1)
                                      ~random:random_119 in
                                  let t_147 = 0. +. 1. in
                                  let t_148 = t_147 +. 1. in
                                  let t_149 =
                                    if (Base.Float.compare 0. t_148) > 0
                                    then Stdlib.failwith "Crossed bounds!"
                                    else
                                      if
                                        Stdlib.not
                                          ((Stdlib.Float.is_finite 0.) &&
                                              (Stdlib.Float.is_finite t_148))
                                      then Stdlib.failwith "Infite floats"
                                      else
                                        Fast_gen.C_sr_dropin_random_runtime.float_c_unchecked
                                          random_119 0. t_148 in
                                  let t_150 =
                                    (Stdlib.Float.compare t_149 1.) <= 0 in
                                  (if t_150
                                    then
                                      T
                                        (R, t_146,
                                          (1000 lxor
                                            (- (Base.Bool.to_int t_133))),
                                          (t_132 lxor
                                            (- (Base.Bool.to_int t_128))),
                                          t_127)
                                    else
                                      (let t_151 = t_149 -. 1. in
                                      let t_152 =
                                        (Stdlib.Float.compare t_151 1.) <= 0 in
                                      if t_152
                                      then
                                        T
                                          (B, t_146,
                                            (1000 lxor
                                                (- (Base.Bool.to_int t_133))),
                                            (t_132 lxor
                                                (- (Base.Bool.to_int t_128))),
                                            t_127)
                                      else
                                        (let t_153 = t_151 -. 1. in
                                          Stdlib.failwith
                                            "Fell of the end of pick list")))
                                else
                                  (let t_137 =
                                      Fast_gen.C_sr_dropin_random_runtime.int_c_log_uniform
                                        random_119 0 1000 in
                                    let t_138 =
                                      go_116 (Obj.magic 0) ~size:(size_118 - 1)
                                        ~random:random_119 in
                                    let t_139 = 0. +. 1. in
                                    let t_140 = t_139 +. 1. in
                                    let t_141 =
                                      if (Base.Float.compare 0. t_140) > 0
                                      then Stdlib.failwith "Crossed bounds!"
                                      else
                                        if
                                          Stdlib.not
                                            ((Stdlib.Float.is_finite 0.) &&
                                              (Stdlib.Float.is_finite t_140))
                                        then Stdlib.failwith "Infite floats"
                                        else
                                          Fast_gen.C_sr_dropin_random_runtime.float_c_unchecked
                                            random_119 0. t_140 in
                                    let t_142 =
                                      (Stdlib.Float.compare t_141 1.) <= 0 in
                                    if t_142
                                    then
                                      T
                                        (R, t_138,
                                          (t_137 lxor
                                            (- (Base.Bool.to_int t_133))),
                                          (t_132 lxor
                                            (- (Base.Bool.to_int t_128))),
                                          t_127)
                                    else
                                      (let t_143 = t_141 -. 1. in
                                      let t_144 =
                                        (Stdlib.Float.compare t_143 1.) <= 0 in
                                      if t_144
                                      then
                                        T
                                          (B, t_138,
                                            (t_137 lxor
                                                (- (Base.Bool.to_int t_133))),
                                            (t_132 lxor
                                                (- (Base.Bool.to_int t_128))),
                                            t_127)
                                      else
                                        (let t_145 = t_143 -. 1. in
                                          Stdlib.failwith
                                            "Fell of the end of pick list")))))))
                    else
                      (let t_126 = t_124 -. 1. in
                        Stdlib.failwith "Fell of the end of pick list"))) in
            go_116 t_115 ~size:size_113 ~random:random_114 in
          t_224)
end