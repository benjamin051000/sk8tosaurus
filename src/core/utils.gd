extends Node

class Interval:
	var include_lo: bool
	var lo
	var hi
	var include_hi: bool
	
	# Insane that I have to do this to get rid of shadowing warnings
	func _init(include_lo_: bool, lo_, hi_, include_hi_: bool):
		assert(lo_ <= hi_)
		self.include_lo = include_lo_
		self.lo = lo_
		self.hi = hi_
		self.include_hi = include_hi_
	
	func contains(x) -> bool:
		var lo_check: bool
		if include_lo:
			lo_check = lo <= x
		else:
			lo_check = lo < x
		
		var hi_check: bool
		if include_hi:
			hi_check = x <= hi
		else:
			hi_check = x < hi
		
		return lo_check and hi_check

signal start_game
signal hit_you
signal game_over
