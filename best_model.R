library(forecast)
library(fpp)

tryCatch({
	
	findBestModel <- function(Stockadd){
		
		Stock = Stockadd
		
		backUpStock = read.table(paste(getwd(), "/input/INFY.csv", sep = ""), sep=",", header=TRUE);
		
		tryCatch({
			tsStock = ts(rev(Stock$Close), start = c(2004, 1), frequency = 12)
		},
		error = function(e){
			tsStock = ts(rev(Stock$Close), start = c(2010, 1), frequency = 12)
		})
		
		tryCatch({
			tsBackUpStock = ts(rev(backUpStock$Close), start = c(2004, 1), frequency = 12)
		},
		error = function(e){
			backUpStock = ts(rev(Stock$Close), start = c(2010, 1), frequency = 12)
		})
		
		tryCatch({
			train <- window(tsBackUpStock, end = 2014)
		},
		error = function(e){
			train = 0 
		})
		
		tryCatch({
			test <- window(tsBackUpStock, start = 2017)
		},
		error = function(e){
			test = 0
		})
		
		tryCatch({
			Btrain <- window(tsBackUpStock, end = 2014)
		},
		error = function(e){
			Btrain = 0
		})
		
		tryCatch({
			Btest <- window(tsBackUpStock, start = 2017)
		},
		error = function(e){
			Btest = 0
		})
		
		tryCatch({
			train <- window(tsStock, end = 2014)
		},
		error = function(e){
			train = 0
		})
		
		tryCatch({
			test <- window(tsStock, start = 2017)
		},
		error = function(e){
			test = 0
		})
		
		if (test[1] == Btest[1] && test[2] == Btest[2] && test[3] == Btest[3]){
			train = Btrain
		}
		
		tryCatch({
			mae = matrix(NA, 25, length(test)+1)
		},
		error = function(e){
			mae = matrix(NA, 25, 10000)
		})
		
		tl = seq(2004, 2017, length = length(train))
		
		tl2 = tl^7
		
		tryCatch({
			polyStock = lm(train ~ tl + tl2)
		},
		error = function(e){
			polyStock = 0
		})
		
		tryCatch({
			tsStocktrend1 = ts(polyStock$fit, start = c(2004, 1), frequency = 12)
		},
		error = function(e){
			tsStocktrend1 = 0
		})
		
		tryCatch({
			stlStock = stl(train, s.window = "periodic")
		},
		error = function(e){
			stlStock = 0
		})
		
		tryCatch({
			tsStocktrend2 = stlStock$time.series[ ,2]
		},
		error = function(e){
			tsStocktrend2 = 0
		})
		
		tryCatch({
			HWStock1_ng = HoltWinters(tsStocktrend1, gamma = FALSE)
		},
		error = function(e){
			HWStock1_ng = 0
		})
		
		tryCatch({
			HWStock1 = HoltWinters(tsStocktrend1)
		},
		error = function(e){
			HWStock1 = 0
		})
		
		tryCatch({
			NETfit1 <- nnetar(tsStocktrend1)
		},
		error = function(e){
			NETfit1 = 0
		})
		
		tryCatch({
			autofit1 = auto.arima(tsStocktrend1)
		},
		error = function(e){
			autofit1 = 0
		})
		
		tryCatch({
			fit12 <- arima(tsStocktrend1, order = c(1, 0, 0), list(order = c(2, 1, 0), period = 12))
		},
		error = function(e){
			fit12 = 0
		})
		
		tryCatch({
			fitl1 <- tslm(tsStocktrend1 ~ trend + season, lambda = 0)
		},
		error = function(e){
			fitl1 = 0
		})
		
		tryCatch({
			stlStock1 = stl(tsStocktrend1, s.window = "periodic")
		},
		error = function(e){
			stlStock1 = 0
		})
		
		tryCatch({
			HWStock2_ng = HoltWinters(tsStocktrend2, gamma = FALSE)
		},
		error = function(e){
			HWStock2_ng = 0
		})
		
		tryCatch({
			HWStock2 = HoltWinters(tsStocktrend2)
		},
		error = function(e){
			HWStock2 = 0
		})
		
		tryCatch({
			NETfit2 <- nnetar(tsStocktrend2)
		},
		error = function(e){
			NETfit2 = 0
		})
		
		tryCatch({
			autofit2 = auto.arima(tsStocktrend2)
		},
		error = function(e){
			autofit2 = 0
		})
		
		tryCatch({
			fit2 <- arima(tsStocktrend2, order = c(15, 3, 3))
		},
		error = function(e){
			fit2 = 0
		})
		
		tryCatch({
			fit22 <- arima(tsStocktrend2, order = c(1, 0, 0), list(order = c(2, 1, 0), period = 12))
		},
		error = function(e){
			fit22 = 0
		})
		
		tryCatch({
			fitl2 <- tslm(tsStocktrend2 ~ trend + season, lambda = 0)
		},
		error = function(e){
			fitl2 = 0
		})
		
		tryCatch({
			stlStock2 = stl(tsStocktrend1, s.window = "periodic")
		},
		error = function(e){
			stlStock2 = 0
		})
		
		tryCatch({
			HWStockr_ng = HoltWinters(train, gamma = FALSE)
		},
		error = function(e){
			HWStockr_ng = 0
		})
		
		tryCatch({
			HWStockr = HoltWinters(train)
		},
		error = function(e){
			HWStockr = 0
		})
		
		tryCatch({
			NETfitr <- nnetar(train)
		},
		error = function(e){
			NETfitr = 0
		})
		
		tryCatch({
			autofitr = auto.arima(train)
		},
		error = function(e){
			autofitr = 0
		})
		
		tryCatch({
			fitr <- arima(train, order = c(15, 3, 3))
		},
		error = function(e){
			fitr = 0
		})
		
		tryCatch({
			fitr2 <- arima(train, order = c(1, 0, 0), list(order = c(2, 1, 0), period = 12))
		},
		error = function(e){
			fitr2 = 0
		})
		
		tryCatch({
			fitlr <- tslm(train ~ trend + season, lambda = 0)
		},
		error = function(e){
			fitlr = 0
		})
		
		tryCatch({
			stlStockr = stl(train, s.window = "periodic")
		},
		error = function(e){
			stlStockr = 0
		})
		
		
		tryCatch({
			HWStockr_ng = HoltWinters(train, gamma = FALSE)
		},
		error = function(e){
			HWStockr_ng = 0
		})
		
		tryCatch({
			predautofitr = window(forecast(autofitr, h = 39)$mean, start = 2013)
		},
		error = function(e){
			predautofitr = 0
		})
		
		tryCatch({
			predfitr = window(forecast(fitr, h = 39)$mean, start = 2017)
		},
		error = function(e){
			predfitr = 0
		})
		
		tryCatch({
			predfitr2 = window(forecast(fitr2, h = 39)$mean, start = 2017)
		},
		error = function(e){
			predfitr2 = 0
		})
		
		tryCatch({
			predNETfitr = window(forecast(NETfitr, h = 39)$mean, start = 2017)
		},
		error = function(e){
			predNETfitr = 0
		})
		
		tryCatch({
			predHWStockr = window(predict(HWStockr, n.ahead = 39), start = 2017)
		},
		error = function(e){
			predHWStockr = 0
		})
		
		tryCatch({
			predHWStockr_ng = window(predict(HWStockr_ng, n.ahead = 39), start = 2017)
		},
		error = function(e){
			predHWStockr_ng  = 0
		})
		
		tryCatch({
			predautofit2 = window(forecast(autofit2, h = 39)$mean, start = 2017)
			# print(predict(predautofit2, n.ahead = 12))
		},
		error = function(e){
			predautofit2 = 0
		})
		
		tryCatch({
			predfit12 = window(forecast(fit12, h = 39)$mean, start = 2017)
		},
		error = function(e){
			predfit12 = 0
		})
		
		tryCatch({
			predfit2 = window(forecast(fit2, h = 39)$mean, start = 2017)
		},
		error = function(e){
			predfit2 = 0
		})
		
		tryCatch({
			predfit22 = window(forecast(fit22, h = 39)$mean, start = 2017)
		},
		error = function(e){
			predfit22 = 0
		})
		
		tryCatch({
			predstlStock1 = window( forecast(stlStock1, h = 39)$mean, start = 2017)
		},
		error = function(e){
			predstlStock1 = 0
		})
		
		tryCatch({
			predstlStock2 = window(forecast(stlStock2, h = 39)$mean, start = 2017)
		},
		error = function(e){
			predstlStock2 = 0
		})
		
		tryCatch({
			predstlStockr = window(forecast(stlStockr, h = 39)$mean, start = 2017)
		},
		error = function(e){
			predstlStockr = 0
		})
		
		tryCatch({
			predNETfit2 = window(forecast(NETfit2, h = 39)$mean, start = 2017)
		},
		error = function(e){
			predNETfit2 = 0
		})
		
		tryCatch({
			predHWStock2 = window(predict(HWStock2, n.ahead = 39), start = 2017)
		},
		error = function(e){
			predHWStock2 = 0
		})
		
		tryCatch({
			predHWStock2_ng = window(predict(HWStock2_ng, n.ahead = 39), start = 2017)
		},
		error = function(e){
			predHWStock2_ng = 0
		})
		
		tryCatch({
			predautofit1 = window(forecast(autofit1, h = 39)$mean, start = 2017)
		},
		error = function(e){
			predautofit1 = 0
		})
		
		tryCatch({
			predfitlr = window(forecast(fitlr, h = 39)$mean , start = 2017)
		},
		error = function(e){
			predfitlr = 0
		})
		
		tryCatch({
			predfitl1 = window(forecast(fitl1, h = 39)$mean, start = 2017)
		},
		error = function(e){
			predfitl1 = 0
		})
		
		tryCatch({
			predfitl2 = window(forecast(fitl2, h = 39)$mean , start = 2017)
		},
		error = function(e){
			predfitl2 = 0
		})
		
		tryCatch({
			predNETfit1 = window(forecast(NETfit1, h = 39)$mean, start = 2017)
		},
		error = function(e){
			predNETfit1 = 0
		})
		
		tryCatch({
			predHWStock1_ng = window(predict(HWStock1_ng, n.ahead = 39), start = 2017)
		},
		error = function(e){
			predHWStock1_ng = 0
		})
		
		tryCatch({
			predHWStock11 = window(predict(HWStock1, n.ahead = 39, prediction.interval = T, level = 0.95)[,1], start = 2017)
		},
		error = function(e){
			predHWStock11 = 0
		})
		
		tryCatch({
			predHWStock12 = window(predict(HWStock1, n.ahead = 39, prediction.interval = T, level = 0.95)[,2], start = 2017)
		},
		error = function(e){
			predHWStock12 = 0
		})
		
		tryCatch({
			predHWStock13 = window(predict(HWStock1, n.ahead = 39, prediction.interval = T, level = 0.95)[,3], start = 2017)
		},
		error = function(e){
			predHWStock13 = 0
		})
		
		for(i in 1:length(test)){
			
			tryCatch({
				mae[1, i] <- abs(predautofitr[i]-test[i])
			},
			error = function(e) { })
			
			tryCatch({
				mae[2, i] <- abs(predfitr[i]-test[i])
			},
			error = function(e) { })
			
			tryCatch({
				mae[3, i] <- abs(predfitr2[i]-test[i])
			},
			error = function(e) { })
			tryCatch({
				mae[4, i] <- abs(predNETfitr[i]-test[i])
			},
			error = function(e) { })
			
			tryCatch({
				mae[5, i] <- abs(predHWStockr[i]-test[i])
			},
			error = function(e) { })
			
			tryCatch({
				mae[6, i] <- abs(predHWStockr_ng[i]-test[i])
			},
			error = function(e) { })
			
			tryCatch({
				mae[7, i] <- abs(predautofit2[i]-test[i])
			},
			error = function(e) { })
			
			tryCatch({
				mae[8, i] <- abs(predfit12[i]-test[i])
			},
			error = function(e) { })
			
			tryCatch({
				mae[9, i] <- abs(predfit2[i]-test[i])
			},
			error = function(e) { })
			
			tryCatch({
				mae[10, i] <- abs(predfit22[i]-test[i])
			},
			error=function(e) { })
			
			tryCatch({
				mae[11, i] <- abs(predstlStock1[i]-test[i])
			},
			error = function(e) { })
			
			tryCatch({
				mae[12, i] <- abs(predstlStock2[i]-test[i])
			},
			error = function(e) { })
			
			tryCatch({
				mae[13, i] <- abs(predstlStockr[i]-test[i])
			},
			error = function(e) { })
			
			tryCatch({
				mae[14, i] <- abs(predNETfit2[i]-test[i])
			},
			error = function(e) { })
			
			tryCatch({
				mae[15, i] <- abs(predHWStock2[i]-test[i])
			},
			error = function(e) { })
			
			tryCatch({
				mae[16, i] <- abs(predHWStock2_ng[i]-test[i])
			},
			error = function(e) { })
			
			tryCatch({
				mae[17, i] <- abs(predautofit1[i]-test[i])
			},
			error = function(e) { })
			
			tryCatch({
				mae[18, i] <- abs(predfitlr[i]-test[i])
			},
			error = function(e) { })
			
			tryCatch({
				mae[19, i] <- abs(predfitl1[i]-test[i])
			},
			error = function(e) { })
			
			tryCatch({
				mae[20, i] <- abs(predfitl2[i]-test[i])
			},
			error = function(e) { })
			
			tryCatch({
				mae[21, i] <- abs(predHWStock1_ng[i]-test[i])
			},
			error = function(e) { })
			
			tryCatch({
				mae[22, i] <- abs(predNETfit1[i]-test[i])
			},
			error = function(e) { })
			
			tryCatch({
				mae[23, i] <- abs(predHWStock11[i]-test[i])
			},
			error=function(e) { })
			
			tryCatch({
				mae[24, i] <- abs(predHWStock12[i]-test[i])
			},
			error = function(e) { })
			
			tryCatch({
				mae[25, i] <- abs(predHWStock13[i]-test[i])
			},
			error=function(e) { })
		}
		
		for(i in 1:25)
		{
			mae[i,5] = sum(mae[i,1:4])
		}
		
		best = which.min(mae[1:25,5])
		
		cat(" ==> Winning Model ID: ", best )
		
		return (best)
	}
},
error = function(e){
	cat("findBestPrediction failed for:",Stockadd);
})