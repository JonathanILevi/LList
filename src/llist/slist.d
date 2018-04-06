

module llist.slist;



struct Node(T) {
	// A node with the next pointer of `null` is a "Sentinel node".
	Node!T* next;

	T payload;
	alias value = payload;
}





struct SList(T) {
	public {
		Node!T* node = new Node!T;
	}
	public {
		this(Node!T* node) {
			this.node = node;
		}
		this(SList!T slist) {
			this.node = slist.node;
		}
	}
	public {
		@property T value() {
			assert(!empty, "No value, current node is a sentinel.");
			return node.payload;
		}
		typeof(this.node) front() {
			return this.node;
		}
		@property bool empty() {
			import std.stdio;
			"empty ".writeln(node.next);
			return (node.next is null);
		}
	}
	public {
		SList!T dup() {
			return SList!T(this);
		}
		void next() {
			import std.stdio;
			assert(!empty);
			"next ".writeln(node.next);
			node = node.next;
		}
		alias popFront = next;
	}
	public {
		void removeNext() {
			assert(!empty);
			node.next = node.next.next;
		}
		void insertAfter(Node!T* newNode) {
			newNode.next = node.next;
			node.next = newNode;
		}
		void insertAfter(T value) {
			 insertAfter(new Node!T(null, value));
		}
	
		void append(T value) {
			assert(empty, "Can only append to the last node.  If you want to force this operation use `redirect`.");
			node.payload = value;
			node.next = new Node!T;
		}
	
		void redirect(bool checkAtEnd=true)(Node!T* newNode) {
			node.next = newNode;
		}
		void redirect(bool checkAtEnd=true)(SList!T slist) {
			redirect!checkAtEnd(slist.node);
		}
		void redirect(bool checkAtEnd=true)(SListConsumable!T slist) {
			redirect!checkAtEnd(slist.node);
		}
	}
}



unittest {
	import std.stdio;
	import std.algorithm.iteration;
	import std.algorithm.searching;
	
	SList!int s = SList!int();
	s.append(4);
	
	foreach(a;s){
		a.value.writeln;
	}
	////
	s.insertAfter(5);
	s.next;
	s.next;
	writeln;
	foreach(a;s){a.value.writeln;}
	////s.find!(a=>a.empty).append(6);
	
	writeln;
	foreach(a;s){a.value.writeln;}
	writeln;
	foreach(a;s){a.value.writeln;}
	
	s.each!writeln;
	
	
	int[][] a = [[4,6,2],[1,2,3]];
	a.each!writeln;
}










