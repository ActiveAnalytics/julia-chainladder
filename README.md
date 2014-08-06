julia-chainladder
=================

Chain Ladder code for Julia programming language. From the blog http://active-analytics.com/blog/chainladder-julia-r-rcpp/

# Example:

Load the script and create the data:

```
require("chainladder") # loads the chainladder.jl script

# The auto paid data from the ChainLadder package
x = [[101125. 209921 266618 305107 327850 340669 348430 351193 353353 353584];
[102541 203213 260677 303182 328932 340948 347333 349813 350523     NaN];
[114932 227704 298120 345542 367760 377999 383611 385224     NaN     NaN];
[114452 227761 301072 340669 359979 369248 373325     NaN     NaN     NaN];
[115597 243611 315215 354490 372376 382738     NaN     NaN     NaN     NaN];
[127760 259416 326975 365780 386725     NaN     NaN     NaN     NaN     NaN];
[135616 262294 327086 367357     NaN     NaN     NaN     NaN     NaN     NaN];
[127177 244249 317972     NaN     NaN     NaN     NaN     NaN     NaN     NaN];
[128631 246803     NaN     NaN     NaN     NaN     NaN     NaN     NaN     NaN];
[126288     NaN     NaN     NaN     NaN     NaN     NaN     NaN     NaN     NaN]]
```

# Funciton to carry out the benchmark for time test

```
# Benchmark
function bench(n::Int)
	output = [@elapsed GetChainSquare(x) for i = 1:n]
	output = output*1E6 # microseconds
	return DataFrames.DataFrame(min = quantile(output, 0), lq = quantile(output, 0.25), 
		median =quantile(output, 0.5), uq = quantile(output, 0.75), 
		max = quantile(output, 1), neval = n)
end
```

The benchmark output

```
bench(1000)

1x6 DataFrame:
           min      lq  median      uq      max neval
[1,]    49.271 50.5192 51.2425 52.0497 173178.0  1000
```
