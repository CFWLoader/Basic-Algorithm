# Nelder Mead Method / Downhill Simplex Method

Pseudo Codes(From Python's scipy/optimize/optimize.py._minimize_neldermead() function):

``` algorithm
Procedure neldermead(objfunc, x_init, simplex_init)
    alpha = 1
    gamma = 2
    rho = 0.5
    sigma = 0.5
    dim_of_param = number of parameter for object function. also can be len(x_init).
    // The following two variables are for initializing the polyhedron.
    nonzdelt = 0.05
    zdelt = 0.00025
    // Initialize the simplex.
    if simplex_init is not set:
        simplex = Array(size = dim_of_param + 1)
        simplex[0] = x_init
        for idx in 1..dim_of_param:
            x_copy = x_init.copy()
            if x_copy[idx - 1] != 0:
                x_copy[idx - 1] = x_init[idx - 1] * nonzdelt
            else:
                x_copy[idx - 1] = zdelt
    fsimplex = Array(size = dim_of_param + 1)
    // Calculate all object function values for simplex.
    for idx in 0..(dim_of_param):
        fsimplex = objfunc(simplex[idx])
    sort fsimplex
    sort simplex as fsimplex's order
    // Start searching.
    while conditions are not demanded:          // Conditions can be max iteration or some contraints.
        x0 = centroid(simplex[1..dim_of_param])
        xr = x0 + alpha * (x0 - simplex[dim_of_param])
        shrink = false
        if objfunc(xr) < fsimplex[0]:           // Expansion case.
            xe = x0 + gamma * (xr - x0)
            if objfunc(xe) < objfunc(xr):
                simplex[dim_of_param] = xe
                fsimplex[dim_of_param] = objfunc(xe)
            else:                               // Expansion failed.
                simplex[dim_of_param] = xr
                fsimplex[dim_of_param] = objfunc(xr)
        else:
            if objfunc(xr) < fsimplex[dim_of_param - 1]:    // f(xr) < f(xn), Reflection case.
                simplex[dim_of_param] = xr
                fsimplex[dim_of_param] = objfunc(xr)
            else:
                if objfunc(xr) < fsimplex[dim_of_param]:    // f(xr) < f(x[n+1]), Contraction case.
                    xc = x0 + rho * alpha * (x0 - simplex[dim_of_param])
                    if objfunc(xc) < objfunc(xr):
                        simplex[dim_of_param] = xc
                        fsimplex[dim_of_param] = objfunc(xc)
                    else:                           
                        shrink = true
                else:                               // Inside contraction case.
                    xc = x0 + rho * (simplex[dim_of_param] - x0)
                    if objfunc(xc) < fsimplex[dim_of_param]:
                        simplex[dim_of_param] = xc
                        fsimplex[dim_of_param] = objfunc(xc)
                    else:                           
                        shrink = true
        if shrink:                              // Other cases are failed, do shrink.
            for i in 1..dim_of_param:
                simplex[i] = simplex[0] + sigma(simplex[i] - simplex[0])
                fsimplex[i] = objfunc(simplex[i])
        sort fsimplex
        sort simplex as fsimplex's order
    return simplex[0]
```