# distance 'single link'

distc <- function(X, CluDistMat, Clu){
  #nombre total des clusters
  CluNum <- length(Clu)
  # valeur du dernier cluster
  newClu <- Clu[[length(Clu)]]
  # boucler tous les clust sauf le dernier
    for (i in c(1:(CluNum-1))[-newClu]) {
      tmp <- c()
      tmp.c <- 1
      # boucler le contenu des clusters
      for (j in Clu[[i]]) {
        # boucler le contenu du dernier cluster
        for (k in newClu) {
          tmp[tmp.c] <- CluDistMat[j,k]
          tmp.c <- tmp.c+1
        }
      }
      # trouver la distance minimale entre deux clusters
      CluDistMat[CluNum,i] <- min(tmp)
      CluDistMat[i,CluNum] <- min(tmp)
    }
    return(CluDistMat)
}


