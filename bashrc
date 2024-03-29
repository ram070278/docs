alias c="clear"                                                                                                              
                                                                                                                             
# Get local IP.                                                                                                              
alias localip="ifconfig \                                                                                                    
                    | grep 'inet addr' \                                                                                     
                    | grep -v '127.0.0.1' \                                                                                  
                    | cut -d: -f2 \                                                                                          
                    | cut -d' ' -f1"                                                                                         
                                                                                                                             
############################### GIT ####################################################                                                                                                                            
# Aliases                                                                                                                    
alias g='git'                                                                                                                
alias gst='git status'                                                                                                       
alias gd='git diff'                                                                                                          
alias gdc='git diff --cached'                                                                                                
alias gl='git pull'                                                                                                          
alias gup='git pull --rebase'                                                                                                
alias gp='git push'                                                                                                          
alias gd='git diff'                                                                                                          
alias gc='git commit -v'                                                                                                     
alias gc!='git commit -v --amend'                                                                                            
alias gca='git commit -v -a'                                                                                                 
alias gca!='git commit -v -a --amend'                                                                                        
alias gcmsg='git commit -m'                                                                                                  
alias gco='git checkout'                                                                                                     
alias gcm='git checkout master'                                                                                              
alias gr='git remote'                                                                                                        
alias grv='git remote -v'                                                                                                    
alias grmv='git remote rename'                                                                                               
alias grrm='git remote remove'                                                                                               
alias grset='git remote set-url'                                                                                             
alias grup='git remote update'                                                                                               
alias grbi='git rebase -i'                                                                                                   
alias grbc='git rebase --continue'                                                                                           
alias grba='git rebase --abort'                                                                                              
alias gb='git branch'                                                                                                        
alias gba='git branch -a'                                                                                                    
alias gcount='git shortlog -sn'                                                                                              
alias gcl='git config --list'                                                                                                
alias gcp='git cherry-pick'                                                                                                  
alias glg='git log --stat --max-count=10'                                                                                    
alias glgg='git log --graph --max-count=10'                                                                                  
alias glgga='git log --graph --decorate --all'                                                                               
alias glo='git log --oneline --decorate --color'                                                                             
alias glog='git log --oneline --decorate --color --graph'                                                                    
alias gss='git status -s'                                                                                                    
alias ga='git add'                                                                                                           
alias gm='git merge'                                                                                                         
alias grh='git reset HEAD'                                                                                                   
alias grhh='git reset HEAD --hard'                                                                                           
alias gclean='git reset --hard && git clean -dfx'                                                                            
alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'                                                               
                                                                                                                             
alias gpoat='git push origin --all && git push origin --tags'                                                                
alias gmt='git mergetool --no-prompt'                                                                                        
                                                                                                                             
alias gg='git gui citool'                                                                                                    
alias gga='git gui citool --amend'                                                                                           
alias gk='gitk --all --branches'                                                                                             
                                                                                                                             
alias gsts='git stash show --text'                                                                                           
alias gsta='git stash'                                                                                                       
alias gstp='git stash pop'                                                                                                   
alias gstd='git stash drop'                                                                                                  
                                                                                                                             
# Will cd into the top of the current repository                                                                             
# or submodule.                                                                                                              
alias grt='cd $(git rev-parse --show-toplevel || echo ".")'                                                                  
                                                                                                                             
# Git and svn mix                                                                                                            
alias git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'                                              
                                                                                                                             
alias gsr='git svn rebase'                                                                                                   
alias gsd='git svn dcommit'                                                                                                  
                                                                                                                             
# these alias commit and uncomit wip branches                                                                                
alias gwip='git add -A; git ls-files --deleted -z | xargs -r0 git rm; git commit -m "--wip--"'                               
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'                                                   
                                                                                                                             
# these alias ignore changes to file                                                                                         
alias gignore='git update-index --assume-unchanged'                                                                          
alias gunignore='git update-index --no-assume-unchanged'                                                                     
# list temporarily ignored files                                                                                             
alias gignored='git ls-files -v | grep "^[[:lower:]]"'                                                                       
                                                                                                                             
# functions                                                                                                                  
# Will return the current branch name                                                                                        
# Usage example: git pull origin $(current_branch)                                                                           
#                                                                                                                            
function current_branch() {                                                                                                  
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \                                                                             
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return                                                                   
  echo ${ref#refs/heads/}                                                                                                    
}                                                                                                                            
                                                                                                                             
function current_repository() {                                                                                              
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \                                                                             
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return                                                                   
  echo $(git remote -v | cut -d':' -f 2)                                                                                     
}                                                                                                                            
                                                                                                                             
# these aliases take advantage of the previous function                                                                      
alias ggpull='git pull origin $(current_branch)'                                                                             
alias ggpur='git pull --rebase origin $(current_branch)'                                                                     
alias ggpush='git push origin $(current_branch)'                                                                             
alias ggpnp='git pull origin $(current_branch) && git push origin $(current_branch)'                                         
                                                                                                                             
# Pretty log messages                                                                                                        
function _git_log_prettily(){                                                                                                
  if ! [ -z $1 ]; then                                                                                                       
    git log --pretty=$1                                                                                                      
  fi                                                                                                                         
}                                                                                                                            
alias glp="_git_log_prettily"                                                                                                
                                                                                                                             
# Work In Progress (wip)                                                                                                     
# These features allow to pause a branch development and switch to another one (wip)                                         
# When you want to go back to work, just unwip it                                                                            
#                                                                                                                            
# This function return a warning if the current branch is a wip                                                              
function work_in_progress() {                                                                                                
  if $(git log -n 1 2>/dev/null | grep -q -c "\-\-wip\-\-"); then                                                            
    echo "WIP!!"                                                                                                             
  fi                                                                                                                         
}                                                                                                                            
########################### DOCKER ##########################################                                                                                                                             
#alias dpsa='docker ps -a'                                                                                                   
alias dpsa='docker ps -a --format "table {{.Names}}\t{{.Ports}}\t{{.Status}}\t{{.Image}}\t{{.ID}}"'                          
alias dps='docker ps --format "table {{.Names}}\t{{.Ports}}\t{{.Status}}\t{{.Image}}\t{{.ID}}"'                              
# Kill all running containers.                                                                                                                                       
alias dstop='printf "\n>>> Stopping containers\n\n" &&sudo docker stop $(sudo docker ps -q)'                                                                                                                                                                                                                                             
# Delete all stopped containers.                                                                                                                                     
alias dclean='printf "\n>>> Deleting stopped containers\n\n" && sudo docker rm $(sudo docker ps -aq)'                                                                                                                                                                                                                                
# Remove Running containers                                                                                                                                          
alias dremove='printf "\n>>> Stopping and Deleting containers\n\n" && sudo docker rm $(sudo docker stop -t=1 $(docker ps -aq))'                                      
# prefix docker ps with ips                                                                                                                                          
function dips() {                                                                                                                                                    
    docker ps | while read line; do                                                                                                                                  
        if `echo $line | grep -q 'CONTAINER ID'`; then                                                                                                               
            echo -e "IP ADDRESS\t$line"                                                                                                                              
        else                                                                                                                                                         
            CID=$(echo $line | awk '{print $1}');                                                                                                                    
            IP=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" $CID);                                                                                         
            printf "${IP}\t${line}\n"                                                                                                                                
        fi                                                                                                                                                           
    done;                                                                                                                                                            
}                                                                                                                                                                    
                                                                                                                                                                     
dlogs()                                                                                                                                                              
{                                                                                                                                                                    
    docker logs -ft "$@"                                                                                                                                             
}                 

# clean ups entier docker tangled images, vloumes, network and containers.                                                                                           
alias docker-clean=' \                                                                                                                                               
  docker container prune -f ; \                                                                                                                                      
  docker image prune -f ; \                                                                                                                                          
  docker network prune -f ; \                                                                                                                                        
  docker volume prune -f '                                                                                                                                           
                                                                                                                                                                     
alias docker-clean-old=' \                                                                                                                                           
  docker ps --no-trunc -aqf "status=exited" | xargs docker rm ; \                                                                                                    
  docker images --no-trunc -aqf "dangling=true" | xargs docker rmi ; \                                                                                               
  docker volume ls -qf "dangling=true" | xargs docker volume rm'                                                                                                     
  
source <(kubectl completion bash)   
###############################################################################
                                                                                           
