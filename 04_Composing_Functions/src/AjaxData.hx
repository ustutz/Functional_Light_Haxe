package;

typedef Person = {
	var id:Int;
	var name:String;
	var age:Int;
	var address:String;
}

typedef Order = {
	var id:Int;
	var personId:Int;
}
 
class AjaxData {
	
	var persons:Array<Person>;
	var orders:Array<Order>;

	public function new() {
		
		persons = [];
		orders = [];
		
		var person1:Person = {
			id: 4,
			name: "John Donson",
			age: 23,
			address: "444 Sunset Blv, 23425 Mos Eysley"
		}
		
		var order1:Order = {
			id: -1,
			personId: 4
		}
		
		persons.push( person1 );
		orders.push( order1 );
		
	}
	
	public function get( url:String, idObj:Dynamic ):Dynamic { //trace( 'get url:$url idObj:$idObj ' );
		
		var id = idObj.id;
	
		switch url {
			case "http://some.api/order":
				for ( order in orders ) {
					if ( order.id == id ) {
						return order;
					}
				}
				
			case "http://some.api/person":
				for ( person in persons ) {
					if ( person.id == id ) {
						return person;
					}
				}
			case _: return orders; // default
		}
		return null;
	}
	
}