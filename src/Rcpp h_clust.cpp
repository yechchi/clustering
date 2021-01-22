#include <Rcpp.h>
using namespace Rcpp;
#include<vector>

using namespace std;


// [[Rcpp::export]]

double Rcpp_hc( NumericMatrix X, int K, string methode){
    int n = length(X);
    
    #Définit matrice de distance
    double MatDistance_X[n][n];
    for(int i = 0; i < n; i++){
    for(int j = 0; j < n; j++)
    {
        MatDistance_X[i][j] = distc(X)[i][j];
        
        if(MatDistance_X[i][j]==0){
            MatDistance_X[i][j]= NA;
        }
        
      }
    }
    
    #Définit liste de clusters
    int Clust[n] = list();
    for(int i = 0; i < n; i++)
    {
        Clust[i] = i;
    }

    std::vector<int> status(n);
    
    #Définit matrice de distance des nouveauc clusters
    double MatDistCluster[2*n-K][2*n-K];
    for(int i = 0; i < 2*n-K; i++){
        for(int j = 0; j < 2*n-K; j++){
            MatDistCluster[i][j] = NA;
            
                }
      }
    for(int i = 0; i < n; i++){
        for(int j = 0; j < n; j++){
            MatDistCluster[i][j] = MatDistance_X[i][j];
            
        }
    }
    
   double CluDistMatFinal[2*n-K][2*n-K];
    for(int i = 0; i < n; i++){
        for(int j = 0; j < n; j++){
            CluDistMatFinal[i][j] = MatDistCluster[i][j];
            
        }
    }
    
    
    std::vector<int> status(m);
    for (item = 1; iem < n-K; item++) {
        
        minClu = min(CluDistMatFinal);

        std::vector<int> vect(n);
        Clust[n+item] =  vect(Clust[minClu],Clust[minClu]);
        status[minClu[m,]] = 0;
        status[n+item] = 1;
        
        for(int i = 0; i < n; i++){
            for(int j = 0; j < n; j++){
                MatDistCluster[i][j] = distc(X, MatDistCluster, Clust, method)[i][j];
                
            }
        }
    
        #Mis a jour de la matrice CluDistMatFinal
        CluDistMatFinal[minClu[m,],] =  NA;
        CluDistMatFinal[,minClu[m,]] =  NA;
    
        CluDistMatFinal[(n+item),1:(n+item)] = MatDistCluster[(n+item),1:(n+item)];
        
        CluDistMatFinal[1:(n+item),(n+item)] = MatDistCluster[1:(n+item),(n+item)];
        
    }
    finClu = Clust[status==1];
    std::vector<int>  finClu1(p);;
    for (int i= 1; i < length(finClu); i++){
        finClu1[finClu[[item]]] = item;
    }

    
    
    return(list(finClu1, finClu))
    

}

    



