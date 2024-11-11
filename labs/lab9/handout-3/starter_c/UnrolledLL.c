#include "UnrolledLL.h"

uNode* new_unode(uNode** prev, u_int64_t blksize) {
	uNode* nnode = (uNode*) malloc(sizeof(uNode*));
	nnode->next = NULL;

    /* Your code here */

	return nnode;
}

void init_ullist(UnrolledLL* ullist, u_int64_t size, u_int64_t blksize) {
	ullist->head = NULL;
	ullist->len = 0;

	/* Your code here */
}

void iterate_ullist(uNode* uiter) {
	while (uiter != NULL) {
		
        /* Your code here */

		uiter = uiter->next;
	}
}

void clean_uulist(UnrolledLL* ullist) {
    if (ullist != NULL && ullist->head != NULL) {
        uNode* current = ullist->head;
        uNode* next;
 
        while (current != NULL) {
            next = current->next;
            free(current->datagrp);
            free(current);
            current = next;
        }

        ullist->head = NULL;
    }
    return;
}