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
        ('DeleteUnion', ['type', 'staged', 'stagedC', 'stagedCSR']),
        ('InsertUnion', []),
        ('UnionDeleteInsert', ['type', 'staged', 'stagedC', 'stagedCSR']),
        ('UnionUnionAssoc', []),
    ],
}

redblack = {
    'base': [],
    'insert_1': [
        ('InsertPost', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteInsert', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
    ],
    'insert_2': [
        ('InsertPost', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('InsertModel', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('InsertDelete', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteInsert', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('InsertUnion', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
    ],
    'insert_3': [
        ('InsertPost', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('InsertDelete', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('InsertInsert', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('UnionDeleteInsert', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
    ],
    'delete_4': [
        ('DeletePost', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteDelete', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteUnion', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
    ],
    'delete_5': [
        ('DeleteModel', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeletePost', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteDelete', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteInsert', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteUnion', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('UnionDeleteInsert', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
    ],
    'union_6': [
        ('UnionPost', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('UnionModel', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteUnion', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('InsertUnion', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('UnionDeleteInsert', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('UnionUnionAssoc', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
    ],
    'union_7': [
        ('UnionValid', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('UnionPost', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteUnion', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('InsertUnion', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('UnionUnionAssoc', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
    ],
    'union_8': [
        ('UnionPost', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('UnionModel', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteUnion', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('InsertUnion', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('UnionDeleteInsert', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('UnionUnionAssoc', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
    ],
    'miscolor_insert': [
        ('InsertValid', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteInsert', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
    ],
    'miscolor_delete': [('DeleteValid', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR'])],
    # 'miscolordelete': [('DeleteValid', [])],
    'miscolor_balLeft': [
        ('DeleteValid', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteDelete', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
    ],
    'miscolor_balRight': [
        ('DeleteValid', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteDelete', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
    ],
    'miscolor_join_1': [('DeleteValid', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR'])],
    'miscolor_join_2': [
        ('DeleteValid', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteDelete', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
    ],
    'no_balance_insert_1': [
        ('InsertValid', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteInsert', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('InsertDelete', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
    ],
    'no_balance_insert_2': [
        ('InsertValid', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteInsert', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('InsertDelete', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
    ],
    'swap_cd': [
        ('InsertValid', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('InsertModel', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('InsertPost', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteValid', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeletePost', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteModel', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteDelete', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteInsert', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('InsertDelete', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('InsertInsert', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
    ],
    'swap_ad': [
        ('InsertValid', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('InsertModel', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('InsertPost', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteValid', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeletePost', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteModel', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteDelete', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteInsert', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('InsertDelete', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('InsertInsert', ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
    ],
    'swap_bc': [
        ('InsertValid', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('InsertModel', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('InsertPost', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteValid', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeletePost', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteModel', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteDelete', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('DeleteInsert', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('InsertDelete', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
        ('InsertInsert', ['type', 'staged', 'stagedC', 'stagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']),
    ],
}

stlc = {
    'base': [("SinglePreserve", ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']), ("MultiPreserve", ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR'])],
    'shift_var_none': [("SinglePreserve", ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']), ("MultiPreserve", ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR'])],
    'shift_var_all': [("SinglePreserve", ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']), ("MultiPreserve", ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR'])],
    'shift_var_leq': [("SinglePreserve", ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']), ("MultiPreserve", ['type', 'staged', 'stagedC', 'stagedCSR', 'bespoke', 'bespokestaged', 'bespokestagedC', 'bespokestagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR'])],
    'shift_abs_no_incr': [("SinglePreserve", ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']), ("MultiPreserve", ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR'])],
    'subst_var_all': [("SinglePreserve", ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']), ("MultiPreserve", ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR'])],
    'subst_var_none': [("SinglePreserve", ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']), ("MultiPreserve", ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR'])],
    'subst_abs_no_shift': [("SinglePreserve", ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']), ("MultiPreserve", ['type', 'staged', 'stagedC', 'stagedCSR', 'bespoke', 'bespokestaged', 'bespokestagedC', 'bespokestagedCSR', 'bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR'])],
    'subst_abs_no_incr': [("SinglePreserve", ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']), ("MultiPreserve", ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR'])],
    'substTop_no_shift': [("SinglePreserve", ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']), ("MultiPreserve", ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR'])],
    'substTop_no_shift_back': [("SinglePreserve", ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR']), ("MultiPreserve", ['bespokeSingle', 'bespokeSingleStaged', 'bespokeSingleStagedC', 'bespokeSingleStagedCSR'])],
} 

tasks = {'BST': bst, 'RBT': redblack, 'STLC': stlc}