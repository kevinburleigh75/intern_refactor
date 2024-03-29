module UglyTrivia
  class Game
    def initialize
      @players        = []
      @places         = Array.new(6, 0)
      @purses         = Array.new(6, 0)
      @in_penalty_box = Array.new(6, nil)

      @pop_questions     = []
      @science_questions = []
      @sports_questions  = []
      @rock_questions    = []

      @current_player = 0
      @is_getting_out_of_penalty_box = false

      50.times do |i|
        @pop_questions.push     "Pop Question #{i}"
        @science_questions.push "Science Question #{i}"
        @sports_questions.push  "Sports Question #{i}"
        @rock_questions.push    "Rock Question #{i}"
      end
    end

    def add(player_name)
      @players.push player_name
      @places[@players.length] = 0
      @purses[@players.length] = 0
      @in_penalty_box[@players.length] = false

      puts "#{player_name} was added"
      puts "They are player number #{@players.length}"
    end

    def roll(roll)
      puts "#{@players[@current_player]} is the current player"
      puts "They have rolled a #{roll}"

      if @in_penalty_box[@current_player]
        @is_getting_out_of_penalty_box = (roll % 2 != 0)

        if @is_getting_out_of_penalty_box
          puts "#{@players[@current_player]} is getting out of the penalty box"
          ## This fixes a bug if we uncomment it.
          # @in_penalty_box[@current_player] = false
          handle_player_movement(roll: roll)
        else
          puts "#{@players[@current_player]} is not getting out of the penalty box"
        end
      else
        handle_player_movement(roll: roll)
      end
    end

    def was_correctly_answered
      unless @in_penalty_box[@current_player] and !@is_getting_out_of_penalty_box
        do_correct_answer
      end

      game_should_continue = !current_player_is_a_winner?
      return game_should_continue
    end

    def was_incorrectly_answered
      puts 'Question was incorrectly answered'
      puts "#{@players[@current_player]} was sent to the penalty box"
      @in_penalty_box[@current_player] = true

      game_should_continue = true
      return game_should_continue
    end

    def advance_to_next_player
      @current_player = (@current_player + 1) % @players.length
    end

  private

    def handle_player_movement(roll: roll)
      advance_player_position(roll: roll)
      puts "#{@players[@current_player]}'s new location is #{@places[@current_player]}"
      puts "The category is #{current_category}"
      ask_question
    end

    def advance_player_position(roll:)
      @places[@current_player] = (@places[@current_player] + roll) % 12
    end

    def do_correct_answer
      puts 'Answer was correct!!!!'

      @purses[@current_player] += 1
      puts "#{@players[@current_player]} now has #{@purses[@current_player]} Gold Coins."
    end

    def ask_question
      puts @pop_questions.shift     if current_category == 'Pop'
      puts @science_questions.shift if current_category == 'Science'
      puts @sports_questions.shift  if current_category == 'Sports'
      puts @rock_questions.shift    if current_category == 'Rock'
    end

    def current_category
      return 'Pop'     if @places[@current_player] == 0
      return 'Pop'     if @places[@current_player] == 4
      return 'Pop'     if @places[@current_player] == 8
      return 'Science' if @places[@current_player] == 1
      return 'Science' if @places[@current_player] == 5
      return 'Science' if @places[@current_player] == 9
      return 'Sports'  if @places[@current_player] == 2
      return 'Sports'  if @places[@current_player] == 6
      return 'Sports'  if @places[@current_player] == 10
      return 'Rock'
    end

    # def is_playable?  ## this unused?
    #   how_many_players >= 2
    # end

    def current_player_is_a_winner?
      @purses[@current_player] == 6
    end
  end
end
