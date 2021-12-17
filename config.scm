(use-modules (gnu) (gnu system nss) (srfi srfi-1))
(use-service-modules desktop xorg sddm)
(use-package-modules certs gnome)

(operating-system
  (host-name "guix")
  (timezone "Europe/Berlin")
  (locale "en_US.utf8")
  (keyboard-layout (keyboard-layout "de"))

  ;; Use the UEFI variant of GRUB with the EFI System
  ;; Partition mounted on /boot/efi.
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets '("/boot/efi"))
                (keyboard-layout keyboard-layout)))

  (file-systems (append
                 (list (file-system
                         (device (file-system-label "my-root"))
                         (mount-point "/")
                         (type "ext4"))
                       (file-system
                         (device "/dev/vda1")
                         (mount-point "/boot/efi")
                         (type "vfat")))
                 %base-file-systems))

  (users (cons (user-account
                (name "moritz")
                (comment "Moritz Hedtke")
                (group "users")
                (supplementary-groups '("wheel" "netdev"
                                        "audio" "video")))
               %base-user-accounts))

  ;; This is where we specify system-wide packages.
  (packages (append (list
                     ;; for HTTPS access
                     nss-certs
                     ;; for user mounts
                     gvfs)
                    %base-packages))

  ;; Add GNOME and Xfce---we can choose at the log-in screen
  ;; by clicking the gear.  Use the "desktop" services, which
  ;; include the X11 log-in service, networking with
  ;; NetworkManager, and more.
  (services (cons*
                          (service sddm-service-type)
                          (service gnome-desktop-service-type)
;                          (set-xorg-configuration
;                           (xorg-configuration
;                            (keyboard-layout keyboard-layout)))

                      (remove (lambda (service)
                        (eq? (service-kind service)
                               gdm-service-type))
                        %desktop-services
                      )))

  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))
