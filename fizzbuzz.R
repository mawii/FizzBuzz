for(i in 1:100) {print(paste0("fizz"[i %% 3 == 0], "buzz"[i %% 5 == 0], i[!any(i %% c(3, 5) == 0)]))}
