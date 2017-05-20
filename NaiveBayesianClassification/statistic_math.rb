module StatisticMath

  @@__pi__ = 3.1415926536

  @@__gaussian_fun_deno__ = 1 / (Math.sqrt 2 * @@__pi__)

  def self.average x

    sum = 0

    x.each { |val| sum += val }

    sum / x.size.to_f

  end

  def self.average_mat x, col_idx

    sum = 0

    x.each { |row|
      sum += row[col_idx]
    }

    sum / x.size.to_f

  end

  def self.square_deviation x

    ave = average x

    sqrt_dev_sum = 0

    x.each { |val| sqrt_dev_sum += (val - ave) ** 2 }

    Math.sqrt(sqrt_dev_sum) / x.size.to_f

  end

  def self.square_deviation_mat x, col_idx

    ave = average_mat x, col_idx

    sqrt_dev_sum = 0

    x.each { |row|
      sqrt_dev_sum += (row[col_idx] - ave) ** 2
    }

    Math.sqrt(sqrt_dev_sum) / x.size.to_f

  end

  def self.gaussian_value miu, omega, pred_val

    exp_val = Math.exp (-(pred_val - miu) ** 2 / (2 * omega ** 2))

    @@__gaussian_fun_deno__ * exp_val / omega

  end

end