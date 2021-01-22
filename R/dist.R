distc <- function(X, CluDistMat, Clu, method){
  #nombre total des clusters
  CluNum <- length(Clu)
  # valeur du dernier cluster
  newClu <- Clu[[length(Clu)]]
  # check la m?thode si elle est 'single'
  if(method == 'single'){
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
  if(method == 'complete'){
    # tous les clust sauf le dernier
    for (i in c(1:(CluNum-1))[-newClu]) {
      tmp <- c()
      tmp.c <- 1
      # contenu des clust
      for (j in Clu[[i]]) {
        # contenu du dernier clust
        for (k in newClu) {
          tmp[tmp.c] <- CluDistMat[j,k]
          tmp.c <- tmp.c+1
        }
      }
      # trouver le max entre 2 clust
      CluDistMat[CluNum,i] <- max(tmp)
      CluDistMat[i,CluNum] <- max(tmp)
    }
    return(CluDistMat)
  }
  if(method == 'average'){
    for (i in c(1:(CluNum-1))[-newClu]) {
      tmp <- c()
      tmp.c <- 1
      for (j in Clu[[i]]) {
        for (k in newClu) {
          tmp[tmp.c] <- CluDistMat[j,k]
          tmp.c <- tmp.c+1
        }
      }
      # trouver la distance maximale
      CluDistMat[CluNum,i] <- sum(tmp)/(length(Clu[[i]])*length(newClu))
      CluDistMat[i,CluNum] <- sum(tmp)/(length(Clu[[i]])*length(newClu))
    }
    return(CluDistMat)
  }
  if(method == 'centroid'){
    # all clust sauf le dernier
    for (i in c(1:(CluNum-1))[-newClu]) {
      # trouver la distance maximale entre deux clusts
      CluDistMat[CluNum,i] <- abs(mean(X[Clu[[i]],])-mean(X[newClu,]))
      CluDistMat[i,CluNum] <- abs(mean(X[Clu[[i]],])-mean(X[newClu,]))
    }
    return(CluDistMat)
}}

