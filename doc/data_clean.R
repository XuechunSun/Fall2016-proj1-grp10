library(data.table)
getwd()
setwd("/Users/sun93/Documents/ADS/Fall2016-proj1-grp10/")

data1 <- fread('ss14pusa.csv')
data2 <- fread('ss14pusb.csv')
data_ori <- rbind(data1, data2)
as.data.table(data_ori)
#dim(data_ori)

databad <- data_ori[(MAR == 3 | MARHT >= 2)]
datagood <- data_ori[(MAR != 3 & MARHT < 2)]

#Define a good marriage attitude
datagood[, fac := 1, ]

#Define a poor marriage attitude
databad1 <- databad[!(MARHT >= 3 | (MARHT == 2 & MAR == 3))]
databad1[, fac := 2, ]

#Define a inferior marriage attitude
databad2 <- databad[MARHT >= 3 | (MARHT == 2 & MAR == 3)]
databad2[, fac := 3, ]

data_f <- rbind(datagood, databad1, databad2)


#DIS (Disability recode)
# 1 .With a disability
# 2 .Without a disability
data_final <- data_f
data_dis <- data_final[!is.na(DIS), list(DIS, PWGTP,fac)]
write.table(data_dis, 'data_dis.csv',sep = ',', row.names = F)


#RAC1P (Recoded detailed race code)
# 1 .White alone
# 2 .Black or African American alone
# 3 .American Indian alone
# 6 .Asian alone
data_final <- data_f
data_RAC1P <- data_final[RAC1P==1|RAC1P==2|RAC1P==3|RAC1P==6, list(RAC1P, PWGTP,fac)]
write.table(data_RAC1P, 'data_RAC1P.csv', sep = ',', row.names = F)

#SCHL (Educational attainment)
# 1 .No schooling completed
# 16 .Regular high school diploma
# 21 .Bachelor's degree
# 22 .Master's degree
# 24 .Doctorate degree
data_final <- data_f
data_SCHL <- data_final[SCHL==1|SCHL==16|SCHL==21|SCHL==22|SCHL==24, list(SCHL,PWGTP, fac)]
write.table(data_SCHL, 'data_SCHL.csv', sep = ',', row.names = F)


#WAGP (Wages or salary income past 12 months)
data_final <- data_f
data_WAGP <- data_final[!is.na(WAGP), list(WAGP, PWGTP,fac)]
write.table(data_WAGP, 'data_WAGP.csv', sep = ',', row.names = F)


#VPS (Veteran period of service)
# 1 .Gulf War: 9/2001 or later
# 6 .Vietnam Era
# 11 .WWII
data_final <- data_f
data_VPS <- data_final[VPS==1|VPS==6|VPS==11, list(VPS, PWGTP,fac)]
write.table(data_VPS, 'data_VPS.csv', sep = ',', row.names = F)


#MIL (Military service)
# 1 .Now on active duty
# 2 .On active duty in the past, but not now
# 3 .Only on active duty for training in Reserves/National Guard 
# 4 .Never served in the military
data_final <- data_f
data_MIL <- data_final[!is.na(MIL), list(MIL, PWGTP,fac)]
write.table(data_MIL, 'data_MIL.csv', sep = ',', row.names = F)


# Data contains all vars mentioned above

data_final <- data_f
data_all_var <- data_final[!is.na(DIS) & (RAC1P==1|RAC1P==2|RAC1P==3|RAC1P==6) & (SCHL==1|SCHL==16|SCHL==21|SCHL==22|SCHL==24) & !is.na(WAGP) & !is.na(MIL), list(DIS, RAC1P, SCHL, WAGP, MIL, PWGTP, fac)]
write.table(data_all_var, 'data_all_var.csv', sep = ',', row.names = F)
