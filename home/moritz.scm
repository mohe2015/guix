(use-modules (gnu home)
             (gnu home services)
             (gnu home services shells)
             (gnu services)
             (gnu packages admin)
             (gnu packages version-control)
             (guix gexp))


(home-environment
 (packages (list htop git))
 (services
  (list
   (service home-bash-service-type
            (home-bash-configuration
             (guix-defaults? #t)
             (bash-profile (list (plain-file "test.sh" "export HISTFILE=$XDG_CACHE_HOME/.bash_history")))))

   (simple-service 'test-config
                   home-files-service-type
                   (list `("gitconfig"
                           ,(plain-file "gitconfig"
                                        "[user]
name = Moritz Hedtke
email = Moritz.Hedtke@t-online.de")))))))
