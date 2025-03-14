
bst = {
    'base': [],
    'insert_1': [
        'InsertPost',
        'DeleteInsert',
    ],
    'insert_2': [
        'InsertPost',
        'InsertModel',
        'InsertDelete',
        'DeleteInsert',
        'InsertUnion',
    ],
    'insert_3': [
        'InsertPost',
        'InsertDelete',
        'InsertInsert',
        'UnionDeleteInsert',
    ],
    'delete_4': [
        'DeletePost',
        'DeleteDelete',
        'DeleteUnion',
    ],
    'delete_5': [
        'DeleteModel',
        'DeletePost',
        'DeleteDelete',
        'DeleteInsert',
        'DeleteUnion',
        'UnionDeleteInsert',
    ],
    'union_6': [
        'UnionPost',
        'UnionModel',
        'DeleteUnion',
        'InsertUnion',
        'UnionDeleteInsert',
        'UnionUnionAssoc',
    ],
    'union_7': [
        'UnionValid',
        'UnionPost',
        'DeleteUnion',
        'InsertUnion',
        'UnionUnionAssoc',
    ],
    'union_8': [
        'UnionPost',
        'UnionModel',
        'DeleteUnion',
        'InsertUnion',
        'UnionDeleteInsert',
        'UnionUnionAssoc',
    ],
}

redblack = {
    'miscolor_insert': [
        'InsertValid',
        'DeleteInsert',
    ],
    'miscolor_delete': ['DeleteValid'],
    'miscolordelete': ['DeleteValid'],
    'miscolor_balLeft': [
        'DeleteValid',
        'DeleteDelete',
    ],
    'miscolor_balRight': [
        'DeleteValid',
        'DeleteDelete',
    ],
    'miscolor_join_1': ['DeleteValid'],
    'miscolor_join_2': [
        'DeleteValid',
        'DeleteDelete',
    ],
    'no_balance_insert_1': [
        'InsertValid',
        'DeleteInsert',
        'InsertDelete',
    ],
    'no_balance_insert_2': [
        'InsertValid',
        'DeleteInsert',
        'InsertDelete',
    ],
    'swap_cd': [
        'InsertValid',
        'InsertModel',
        'InsertPost',
        'DeleteValid',
        'DeletePost',
        'DeleteModel',
        'DeleteDelete',
        'DeleteInsert',
        'InsertDelete',
        'InsertInsert',
    ],
    'swap_ad': [
        'InsertValid',
        'InsertModel',
        'InsertPost',
        'DeleteValid',
        'DeletePost',
        'DeleteModel',
        'DeleteDelete',
        'DeleteInsert',
        'InsertDelete',
        'InsertInsert',
    ],
    'swap_bc': [
        'InsertValid',
        'InsertModel',
        'InsertPost',
        'DeleteValid',
        'DeletePost',
        'DeleteModel',
        'DeleteDelete',
        'DeleteInsert',
        'InsertDelete',
        'InsertInsert',
    ],
}

stlc = {
    'base': ["SinglePreserve", "MultiPreserve"],
    'shift_var_none': ["SinglePreserve", "MultiPreserve"],
    'shift_var_all': ["SinglePreserve", "MultiPreserve"],
    'shift_var_leq': ["SinglePreserve", "MultiPreserve"],
    'shift_abs_no_incr': ["SinglePreserve", "MultiPreserve"],
    'subst_var_all': ["SinglePreserve", "MultiPreserve"],
    'subst_var_none': ["SinglePreserve", "MultiPreserve"],
    'subst_abs_no_shift': ["SinglePreserve", "MultiPreserve"],
    'subst_abs_no_incr': ["SinglePreserve", "MultiPreserve"],
    'substTop_no_shift': ["SinglePreserve", "MultiPreserve"],
    'substTop_no_shift_back': ["SinglePreserve", "MultiPreserve"],
} 

tasks = {'BST': bst, 'RBT': {**bst, **redblack}, 'STLC': stlc}
