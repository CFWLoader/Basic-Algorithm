class Population

  def initialize first_gen_, pop_size_, score_func_, mutate_func_

    @generation = first_gen_

    @pop_size = pop_size_ == nil ? first_gen.size : pop_size_

    @score_func = score_func_

    @mutate_func = mutate_func_

    @iteration_count = 0

  end

  def mutate cur_gen

    mutated = []

    cur_gen.each{|individual|

      mutated << @mutate_func.call(individual)

    }

    mutated.flatten!

    mutated

  end

  def filtrate gen

    gen = gen + @generation

    gen.sort! {|x ,y| @score_func.call(y) <=> @score_func.call(x)}

    gen[0..(@pop_size - 1)]

  end

  def fit

    mutated_gen = mutate @generation

    filtrated_gen = filtrate mutated_gen

    until stable? filtrated_gen

      @iteration_count += 1

      @generation = filtrated_gen

      mutated_gen = mutate @generation

      filtrated_gen = filtrate mutated_gen

    end

    return filtrated_gen, @iteration_count

  end

  def stable? filtrated_gen

    fit_count = 0

    0.upto(@pop_size - 1){|idx|

      if (@generation[idx] - filtrated_gen[idx]).abs <= 0.001 and
          (@score_func.call(@generation[idx]) - @score_func.call(filtrated_gen[idx]).abs <= 0.001)

          fit_count += 1

      end

    }

    fit_count >= (0.7 * @pop_size).to_i

  end

end

set_mutate_func = Proc.new {|individual|

  prng = Random.new

  probability = []

  1.upto(10) {

    gened = individual + prng.rand(-20.0..20.0)

    if 1.0 <= gened and gened <= 20.0

      probability << gened

    end

  }

  probability

}

first_gen = []

prng = Random.new

1.upto(100) {first_gen << prng.rand(1.0..200000.0)}

pop = Population.new first_gen, 100, lambda {|x| x * Math.cos(x) + 2}, set_mutate_func

final_pop, iteration_count = pop.fit

puts final_pop
puts iteration_count