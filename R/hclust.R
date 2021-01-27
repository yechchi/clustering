hc <- function(X, K){
  MatDistance_X <- as.matrix(dist(X)) # Matrice distance de X bas?e sur la distance euclidienne
  MatDistance_X[MatDistance_X==0] <- NA #transformer tous les 0 en NA, on aura donc aucune distance nulle
  Clust <- list()# Clust contiendra les cluster form?s
  #initialisation des clusters, chaque individu sera un cluster
  for (clu in 1:nrow(X)) {Clust[[clu]] <- clu}

  #Statut st un indicateur de regroupage , 1 si pas encore regroup?, 0 si oui.
  status <- c(rep(1,nrow(X)))# Au d?but, aucun cluster n'a ?t? rgroup?, donc statut contiendra que des 1.

  MatDistCluster <- matrix(NA,2*nrow(X)-K,2*nrow(X)-K)

  MatDistCluster[1:nrow(MatDistance_X),1:ncol(MatDistance_X)] <- MatDistance_X
  CluDistMatFinal <- MatDistCluster

  for (item in 1:(nrow(X)-K)) {
    # Recherche des individus ayant la plus petite distance
    minClu <- which(CluDistMatFinal==min(CluDistMatFinal, na.rm=TRUE), arr.ind=T)# Recherche des indices du minimum des distances
    #cr?ation d'un cluster contenant les clusters form?s ? cette ?tape.
    Clust[[nrow(X)+item]] <- c(Clust[[minClu[nrow(minClu),1]]],Clust[[minClu[nrow(minClu),2]]])

    #Affectation de 0 au statut des indices des clusters form?s
    status[minClu[nrow(minClu),]] <- 0
    #Affectation de 1 au nouveau cluster
    status[nrow(X)+item] <- 1


    # On doit reclculer les distances entre ce nouveau cluster et les autres,
    #ce calcul se fera avec la fonction dist. Cela dans le but de cr?er un nouveau cluster qui sera Constitu? des 2 clusters les plus proches.
    # Mise ? jour de la matrice de distance
    MatDistCluster <- distc(X, MatDistCluster, Clust)
    # A cette ?tape, MatDistCluster contient et la matrice de distance initiale et les nouvelles distances entre les anciens clusters et le  nouveau
    # Il nous faut maintenant supprimer de la matrice CluDistMatFinal les clusters deja regroup?s

    # Mise ? jour de CluDistMatFinal
    CluDistMatFinal[minClu[nrow(minClu),],] <- NA
    CluDistMatFinal[,minClu[nrow(minClu),]] <- NA

    # Il faut ajouter ? CluDistMatFinal les nouvelles distances calcul?es

    CluDistMatFinal[(nrow(X)+item),1:(nrow(X)+item)] <- MatDistCluster[(nrow(X)+item),1:(nrow(X)+item)]# cas de la matrice triangulaire inferieur

    CluDistMatFinal[1:(nrow(X)+item),(nrow(X)+item)] <- MatDistCluster[1:(nrow(X)+item),(nrow(X)+item)]# cas de la matrice triangulaire sup?rieur

  }
  finClu <- Clust[status==1]# status==1 represente les individus qui n'ont pas encore ?t? regroup?
  finClu1 <- c()
  for (item in 1:length(finClu))finClu1[finClu[[item]]] <- item

  cat('Les labels des clusters finaux:\n',finClu1,'\n')

  return(list(finClu1, finClu))
}
