#include "UnrolledLL.h"

/*
 * Name: Dylan Faulhaber and Jack Patterson
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System
*/

/**
 * Constructor for a node in the unrolled linked list.
 * This should create a node with the given block siz.
 * @param size Size of the list
 * @param blksize Size of each block
 */
uNode::uNode(uNode* prev, u_int64_t blksize) : blksize(blksize) {
	/* Implement me! */
	next = nullptr;
	datagrp = new int[blksize];
	for(int i=0; i<blksize; i++){
		datagrp[i] = rand() % 100;
	}
	if (prev == nullptr)
		prev = this;
	else
		prev->next = this;
}

/**
 * Destructor for a node in the unrolled linked list.
 * This should deallocate all memory associated with the uNode.
 */
uNode::~uNode() {
	delete[] datagrp;
}

/**
 * Constructor for the unrolled linked list.
 * This should create a linked list of uNodes.
 * @param size Size of the list
 * @param blksize Size of each block
 */
UnrolledLL::UnrolledLL(u_int64_t size, u_int64_t blksize) {
	/* Implement me! */
	head = nullptr;
	len = 0;
	uNode* nnode;

	for (u_int64_t i = 0; i < size/blksize; i++) {
		if (i == 0)
			head = nnode = new uNode(head, blksize);
		else
			nnode = new uNode(nnode, blksize);
		len++;
	}
}

/**
 * Destructor for the unrolled linked list.
 * This should deallocate all memory associated with the unrolled linked list.
 */
UnrolledLL::~UnrolledLL() {
	uNode* current = head;
	uNode* next;

	while (current != nullptr) {
		next = current->next;
		delete current;
		current = next;
	}

	head = nullptr;
}

/**
 * Iterate through the unrolled linked list.
 * Simply iterate through the unrolled linked list and access each element.
 */
void UnrolledLL::iterate_ullist() {
	/* Implement me! */
	uNode* iter = head;
	while(iter != nullptr){
		for(int i=0; i<iter->blksize; i++){
			int num = iter->datagrp[i];
		}
		iter = iter->next;
	}

}
