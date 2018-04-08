

module llist.slist;



struct Node(T) {
	// A node with the next pointer of `null` is a "Sentinel node".
	Node!T* next;

	T payload;
	alias value = payload;
}



public {
	@property bool empty(T)(Node!T* node) {
		return (node.next is null);
	}
}
public {
	Node!T dup(T)(Node!T* node) {
		return new Node!T(node.next, node.payload);
	}
}
public {
	void removeNext(T)(Node!T* node) {
		assert(!node.empty);
		node.next = node.next.next;
	}
	void insertAfter(T)(Node!T* node, Node!T* newNode) {
		newNode.next	= node.next;
		node.next	= newNode;
	}
	void insertAfter(T)(Node!T* node, T value) {
		node.insertAfter(new Node!T(null, value));
	}

	void append(T)(Node!T* node, T value) {
		assert(node.empty, "Can only append to the last node.  If you want to force this operation use `redirect`.");
		node.payload	= value;
		node.next	= new Node!T;
	}

	void redirect(bool checkAtEnd=true, T)(Node!T* node, Node!T* newNode) {
		node.next = newNode;
	}
}

public {
	Iterator!T iterator(T)(Node!T* node) {
		return Iterator!T(node);
	}
	private struct Iterator(T) {
		private Node!T* node;
		@disable this();
		this(Node!T* node) {
			this.node = node;
		}
		@property bool empty() {
			return node.empty;
		}
		@property Node!T* front() {
			assert(!empty);
			return node;
		}
		void popFront() {
			assert(!empty);
			node = node.next;
		}
	}
}


unittest {
	import std.stdio;
	import std.algorithm.iteration;
	import std.algorithm.searching;

	Node!int* s = new Node!int();
	s.append(4);

	foreach(a;s.iterator){
		a.value.writeln;
	}
	////
	s.insertAfter(5);
	////s = s.next;
	////s = s.next;
	writeln;
	foreach(a;s.iterator){a.value.writeln;}
	////s.find!(a=>a.empty).append(6);

	writeln;
	foreach(a;s.iterator){a.value.writeln;}
	writeln;
	foreach(a;s.iterator){a.value.writeln;}

	s.iterator.each!(a=>a.value.writeln);


	int[][] a = [[4,6,2],[1,2,3]];
	a.each!writeln;
}










