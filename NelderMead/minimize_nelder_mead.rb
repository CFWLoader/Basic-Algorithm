def minize_nelder_mead(objfun, x_init, simplex_init = nil)
    alpha = 1
    gamma = 2
    rho = 0.5
    sigma = 0.5
    nonzdelt = 0.05
    zdelt = 0.00025
    num_params = x_init.length
    # print objfun.call(x_init)
    simplex = nil
    if simplex_init.nil?

    else
    end
end

len = 1000
lnSum = -588.1445084464773
lnOneMinusSum = -1092.6313364051173

objfun_beta = Proc.new {|params|
    a = params[0].to_f
    b = params[1].to_f
    lga = Math.lgamma(a)
    lgb = Math.lgamma(b)
    lgab = Math.lgamma(a + b)
    -(len * lgab[0] * lgab[1] - len * lga[0] * lga[1] - len * lgb[0] * lgb[1] + (a - 1) * lnSum + (b - 1) * lnOneMinusSum) 
}

if __FILE__ == $0
    minize_nelder_mead(objfun_beta, [3, 2])
end

#  let objFuncBeta = (params) => {
#      let a = params[0], b = params[1];
#  	return -(len * mathjs.log(mathjs.gamma(a + b)) - len * mathjs.log(mathjs.gamma(a)) - len * mathjs.log(mathjs.gamma(b)) +
# 		(a - 1) * lnSum + (b - 1) * lnOneMinusSum);
# };

# let result = minizeNelderMead(objFuncBeta, [2.8148403344142907,1.87300183956733]);
# par1 = 2.84255334896478, par2 = 1.897010225091196