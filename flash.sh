sudo avrdude -p m128 -c usbasp -U flash:w:"$1":r
