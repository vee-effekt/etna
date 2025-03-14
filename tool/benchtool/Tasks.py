# map from workload -> variant -> property -> strategy *to exclude*
# Note: the type format of this file was changed on 3/14, and I used an LLM to do the transformation.
# Hoopefully it's still correct.

bst = {
    'base': [],
    'insert_1': [
        ('InsertPost', []),
        ('DeleteInsert', []),
    ],
    'insert_2': [
        ('InsertPost', []),
        ('InsertModel', []),
        ('InsertDelete', []),
        ('DeleteInsert', []),
        ('InsertUnion', []),
    ],
    'insert_3': [
        ('InsertPost', []),
        ('InsertDelete', []),
        ('InsertInsert', []),
        ('UnionDeleteInsert', []),
    ],
    'delete_4': [
        ('DeletePost', []),
        ('DeleteDelete', []),
        ('DeleteUnion', []),
    ],
    'delete_5': [
        ('DeleteModel', []),
        ('DeletePost', []),
        ('DeleteDelete', []),
        ('DeleteInsert', []),
        ('DeleteUnion', []),
        ('UnionDeleteInsert', []),
    ],
    'union_6': [
        ('UnionPost', []),
        ('UnionModel', []),
        ('DeleteUnion', []),
        ('InsertUnion', []),
        ('UnionDeleteInsert', []),
        ('UnionUnionAssoc', []),
    ],
    'union_7': [
        ('UnionValid', []),
        ('UnionPost', []),
        ('DeleteUnion', []),
        ('InsertUnion', []),
        ('UnionUnionAssoc', []),
    ],
    'union_8': [
        ('UnionPost', []),
        ('UnionModel', []),
        ('DeleteUnion', ['type', 'staged', 'stagedc', 'stagedcsr']),
        ('InsertUnion', []),
        ('UnionDeleteInsert', ['type', 'staged', 'stagedc', 'stagedcsr']),
        ('UnionUnionAssoc', []),
    ],
}

redblack = {
    'miscolor_insert': [
        ('InsertValid', []),
        ('DeleteInsert', []),
    ],
    'miscolor_delete': [('DeleteValid', [])],
    # 'miscolordelete': [('DeleteValid', [])],
    'miscolor_balLeft': [
        ('DeleteValid', ['type', 'staged', 'stagedc', 'stagedcsr']),
        ('DeleteDelete', ['type', 'staged', 'stagedc', 'stagedcsr']),
    ],
    'miscolor_balRight': [
        ('DeleteValid', ['type', 'staged', 'stagedc', 'stagedcsr']),
        ('DeleteDelete', ['type', 'staged', 'stagedc', 'stagedcsr']),
    ],
    'miscolor_join_1': [('DeleteValid', ['type', 'staged', 'stagedc', 'stagedcsr'])],
    'miscolor_join_2': [
        ('DeleteValid', ['type', 'staged', 'stagedc', 'stagedcsr']),
        ('DeleteDelete', ['type', 'staged', 'stagedc', 'stagedcsr']),
    ],
    'no_balance_insert_1': [
        ('InsertValid', []),
        ('DeleteInsert', ['type', 'staged', 'stagedc', 'stagedcsr']),
        ('InsertDelete', ['type', 'staged', 'stagedc', 'stagedcsr']),
    ],
    'no_balance_insert_2': [
        ('InsertValid', []),
        ('DeleteInsert', ['type', 'staged', 'stagedc', 'stagedcsr']),
        ('InsertDelete', ['type', 'staged', 'stagedc', 'stagedcsr']),
    ],
    'swap_cd': [
        ('InsertValid', []),
        ('InsertModel', []),
        ('InsertPost', []),
        ('DeleteValid', ['type', 'staged', 'stagedc', 'stagedcsr']),
        ('DeletePost', ['type', 'staged', 'stagedc', 'stagedcsr']),
        ('DeleteModel', ['type', 'staged', 'stagedc', 'stagedcsr']),
        ('DeleteDelete', ['type', 'staged', 'stagedc', 'stagedcsr']),
        ('DeleteInsert', []),
        ('InsertDelete', []),
        ('InsertInsert', []),
    ],
    'swap_ad': [
        ('InsertValid', []),
        ('InsertModel', []),
        ('InsertPost', []),
        ('DeleteValid', []),
        ('DeletePost', []),
        ('DeleteModel', []),
        ('DeleteDelete', []),
        ('DeleteInsert', []),
        ('InsertDelete', []),
        ('InsertInsert', []),
    ],
    'swap_bc': [
        ('InsertValid', ['type', 'staged', 'stagedc', 'stagedcsr']),
        ('InsertModel', ['type', 'staged', 'stagedc', 'stagedcsr']),
        ('InsertPost', ['type', 'staged', 'stagedc', 'stagedcsr']),
        ('DeleteValid', ['type', 'staged', 'stagedc', 'stagedcsr']),
        ('DeletePost', ['type', 'staged', 'stagedc', 'stagedcsr']),
        ('DeleteModel', ['type', 'staged', 'stagedc', 'stagedcsr']),
        ('DeleteDelete', ['type', 'staged', 'stagedc', 'stagedcsr']),
        ('DeleteInsert', ['type', 'staged', 'stagedc', 'stagedcsr']),
        ('InsertDelete', ['type', 'staged', 'stagedc', 'stagedcsr']),
        ('InsertInsert', ['type', 'staged', 'stagedc', 'stagedcsr']),
    ],
}

stlc = {
    'base': [("SinglePreserve", []), ("MultiPreserve", [])],
    'shift_var_none': [("SinglePreserve", []), ("MultiPreserve", [])],
    'shift_var_all': [("SinglePreserve", []), ("MultiPreserve", [])],
    'shift_var_leq': [("SinglePreserve", []), ("MultiPreserve", ['type', 'staged', 'stagedc', 'stagedcsr', 'bespoke', 'bespokestaged', 'bespokestagedc', 'bespokestagedcsr'])],
    'shift_abs_no_incr': [("SinglePreserve", []), ("MultiPreserve", [])],
    'subst_var_all': [("SinglePreserve", []), ("MultiPreserve", [])],
    'subst_var_none': [("SinglePreserve", []), ("MultiPreserve", [])],
    'subst_abs_no_shift': [("SinglePreserve", []), ("MultiPreserve", ['type', 'staged', 'stagedc', 'stagedcsr', 'bespoke', 'bespokestaged', 'bespokestagedc', 'bespokestagedcsr'])],
    'subst_abs_no_incr': [("SinglePreserve", []), ("MultiPreserve", [])],
    'substTop_no_shift': [("SinglePreserve", []), ("MultiPreserve", [])],
    'substTop_no_shift_back': [("SinglePreserve", []), ("MultiPreserve", [])],
} 

tasks = {'BST': bst, 'RBT': {
    **bst, 
    **redblack}, 'STLC': stlc}