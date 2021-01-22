distWard <- function(X, CluDistMat, Clu,status){
  CluNum <- length(Clu)
  newClu <- Clu[[length(Clu)]]
  N_k<-length(newClu)
  bary_new<-colMeans(as.matrix(X[unlist(newClu),]))

  for (i in c(1:(CluNum-1))[-newClu]) {
    if (status[i]==1) {
      bary_i<-X[Clu[[i]],]
      n_i<-dim(t(as.matrix(bary_i)))[1]
      if (n_i!=1) {
        bary_i<-colMeans(as.matrix(X[Clu[[i]],]))
      }

      N1<-n_i+N_k
      N2<-n_i*N_k
      N<-N1/N2
      ward<-N*(sum((bary_new-bary_i)^2))
      CluDistMat[CluNum,i] <- ward
      CluDistMat[i,CluNum] <- ward
    }
  }
  return(CluDistMat)
}
