require './simulation/simulation.rb'
require './visualization/simulation_extension.rb'
require './visualization/visualization.rb'


units1 = [Tank.new(15),Soldier.new(10),Soldier.new(12),Soldier.new(50),Tank.new(8)]
units2 = [Soldier.new(-8),Soldier.new(-3),Soldier.new(-1),Sniper.new(-14),Tank.new(-9)]
army1 = Army.new(units1, SimulationStrategy.new)
army2 = Army.new(units2, SimulationStrategy.new)
battle = BattleProgram.new(army1,army2)



File.open('input.txt','r') { |x|
	#Array of sentences
	sentences = []
	i = 0
	fileInput = ''
	x.each_line{ |line|
		if (i % 2 == 0) #Is even
			fileInput = line
		else
			temporary = line.split('>')
			sentences << {'sentence'=>fileInput,'from_lang'=>temporary[0], 'to_lang'=> temporary[1]}
		end
		i += 1;
	}
}


File.open('output.txt','w') { |output|
sentences.each { |item|
	File.open(item['from_lang']+'_'+item['to_lang']+'.dict', 'r') { |dict|

		dictionary = {}
		dict.each_line { |line|
			x = line.split('|')
			dictionary[x[0]] = x[1]
		}

		words = item['sentence'].split(/[ ,.'"!]/);
		out = ''
		words.each{ |word|
			if(word != ' ')
				if(dictonary[word] != nil)
					out += dictionary[word] + ' ';
				else
					out += word.upcase
				end
			end
		}

		output.puts(out)

	}
}
}



vis = Visualization::Visualization.new(battle)
vis.run

  