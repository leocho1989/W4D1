require_relative './../PolyTreeNode/lib/00_tree_node.rb'
require 'byebug'

MOVES = [[-1,-2],[-2,-1],[-2,1],[-1,2],[1,-2],[2,-1],[2,1],[1,2]]

class KnightPathFinder

  attr_reader :start_pos
  attr_accessor :root_node, :considered_positions

    def self.valid_moves(pos) # [3,3] 
    row, col = pos
    valid = []
    MOVES.each do |ele|
      row2, col2 = ele
      next_pos = [row + row2, col + col2]
        if next_pos[0] < 8 && next_pos[0] >= 0 && next_pos[1] < 8 && next_pos[1] >= 0 
          valid << next_pos
        end
      end
      valid
  end

  def initialize(start_pos)
   @start_pos = start_pos   # the root node is the starting position
   @considered_positions = [start_pos]
   build_move_tree
  end

   def new_move_positions(pos)
    valid_moves = KnightPathFinder.valid_moves(pos)
    new_arr = []  #valid_moves should have 8 different positions inside
    valid_moves.each do |sub_pos|
      if !@considered_positions.include?(sub_pos)
        @considered_positions << sub_pos
        new_arr << sub_pos
      end
    end
    new_arr
  end

  def build_move_tree
    self.root_node = PolyTreeNode.new(start_pos)
    queue = [root_node]
    until queue.empty?
      current_node = queue.shift  #current_node = [3,3]
      current_pos = current_node.value # current_pos = [3,3]
      new_moves = new_move_positions(current_pos)
        new_moves.each do |move| # Iteration 1: move is [2,1]
          next_node = PolyTreeNode.new(move)
          current_node.add_child(next_node)
          queue << next_node
      end
    end
  end



end

p kpf = KnightPathFinder.new([3,3])
kpf.considered_positions.length