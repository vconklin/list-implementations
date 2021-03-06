# Quick Example of a Self Referential Data Structure in Ruby
# NODE -> contains a value and a pointer to (next_node)
# LinkedList -> This class holds the linked list functions - adding a node, traversing and displaying the linked list

class Node
   attr_accessor :value, :next_node

   def initialize(val,next_in_line=nil)
       @value = val
       @next_node = next_in_line
       puts "Initialized a Node with value:  " + value.to_s
   end
end

class LinkedList
   def initialize(val)
       # Initialize a new node at the head
       @head = Node.new(val,nil)
   end

   def add(value)
       # Traverse to the end of the list
       # And insert a new node over there with the specified value
       current = @head
       while current.next_node != nil
           current = current.next_node
       end
       current.next_node = Node.new(value,nil)
       self
   end

   def delete(val)
       current = @head
       if current.value == val
           # If the head is the element to be delete, the head needs to be updated
           @head = @head.next_node
       else
           # ... x -> y -> z
           # Suppose y is the value to be deleted, you need to reshape the above list to :
           #   ... x->z
           # ( and z is basically y.next_node )
           current = @head
           ## wait what's happening in this next while loop? when would current be nil?
           while (current != nil) && (current.next_node != nil) && ((current.next_node).value != val)
               current = current.next_node
           end

           if (current != nil) && (current.next_node != nil)
               current.next_node = (current.next_node).next_node
           end
       end
   end

   def display
       # Traverse through the list till you hit the "nil" at the end
       current = @head
       full_list = []
       while current.next_node != nil
           full_list += [current.value.to_s]
           current = current.next_node
       end
       full_list += [current.value.to_s]
       puts full_list.join("->")
   end

   def include?(key)

     # Traverse through the list till you hit the "nil" at the end
     current = @head
     full_list = []
     while current.next_node != nil
         if current.value == key
           return true
         else
           full_list += [current.value.to_s]
           current = current.next_node
         end
     end

     if current.value == key
       return true
     else
       full_list += [current.value.to_s]
     end

     return false

   end

   def size

     current = @head
     full_list = []
     size_of_list = 0
     while current.next_node != nil
         full_list += [current.value.to_s]
         size_of_list += 1
         current = current.next_node
     end
     full_list += [current.value.to_s]
     size_of_list += 1
     return size_of_list

   end

   def max
   end

end

# Initializing a Linked List with a node containing value (5)
ll = LinkedList.new(5)

# Adding Elements to Linked List
ll.add(10)
ll.add(20)

# Display the Linked List
puts "Displaying Linked List:"
ll.display

puts "Does Linked List include the given value?"
puts "5:"
puts ll.include?(5)
puts "10:"
puts ll.include?(10)
puts "20:"
puts ll.include?(20)
puts "16:"
puts ll.include?(16)

puts "Size of array:"
puts ll.size

puts "Delete 10 and then display the linked list:"
ll.delete(10)
ll.display

puts "Does it still include the given value?"
puts "10:"
puts ll.include?(10)

puts "What is the size now?"
puts ll.size

=begin
Output:
Initialized a Node with value:  5
Initialized a Node with value:  10
Initialized a Node with value:  20
Displaying Linked List:
5->10->20
Delete 10 and then display the linked list:
5->20
=end
