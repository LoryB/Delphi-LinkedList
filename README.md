# Delphi-TLinkedList
Generic Linked List Delphi implementation from C# TLinkedList class

## Description
TLinkedList\<T> is a general-purpose linked list.
TLinkedList\<T> provides separate nodes of type TNode\<T>, so insertion and removal are O(1) operations.
You can remove nodes and reinsert them, either in the same list or in another list, which results in no additional objects allocated on the heap. Because the list also maintains an internal count, getting the Count property is an O(1) operation.
Each node in a TLinkedList\<T> object is of the type TNode\<T>. Because the TLinkedList\<T> is doubly linked, each node points forward to the Next node and backward to the Previous node.
TLinkedList\<T> accepts null as a valid Value property for reference types and allows duplicate values.
If the LinkedList\<T> is empty, the First and Last properties contain null.

## Installation
Just import [LinkedList.pas](LinkedList.pas) in your project or in the IDE library

## Methods and Properties
- <strong>Create</strong>: Initializes a new instance of the TLinkedList<T> class.
- <strong>Destroy</strong>: Destroys the linked list and its elements.
- <strong>AddFirst(Value: T)</strong>: Adds a new node with the specified value at the beginning of the linked list.
- <strong>AddLast(Value: T)</strong>: Adds a new node with the specified value at the end of the linked list.
- <strong>RemoveFirst</strong>: Removes and returns the value of the first node in the linked list.
- <strong>RemoveLast</strong>: Removes and returns the value of the last node in the linked list.
- <strong>Remove(Value: T)</strong>: Boolean: Removes the first occurrence of the specified value from the linked list.
- <strong>Clear</strong>: Removes all nodes from the linked list.
- <strong>Contains(Value: T)</strong>: Boolean: Determines whether the linked list contains a specific value.
- <strong>CopyTo(var ArrayOfT: array of T; Index: Integer)</strong>: Copies the elements of the linked list to an array, starting at a particular index in the array.
- <strong>ElementAt(Index: Integer)</strong>: T: Returns the value at the specified index in the linked list.
- <strong>First: T</strong>: Returns the value of the first node in the linked list.
- <strong>Last: T</strong>: Returns the value of the last node in the linked list.
- <strong>IndexOf(Value: T)</strong>: Integer: Returns the index of the first occurrence of a specific value in the linked list.
- <strong>RemoveAt(Index: Integer)</strong>: T: Removes the node at the specified index in the linked list and returns its value.
- <strong>Count: Integer</strong>: Returns the number of nodes in the linked list.
- <strong>FirstNode: TNode\<T></strong>: Property to get the first node in the linked list.
- <strong>LastNode: TNode\<T></strong>: Property to get the last node in the linked list.
