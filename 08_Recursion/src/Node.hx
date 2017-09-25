package;


class Node {
	
	public var left:Node;
	public var right:Node;

	public function new( left:Node = null, right:Node = null ) {
		this.left = left;
		this.right = right;
	}
	
}