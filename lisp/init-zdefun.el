(require-package 'f)
(require 'f)
(require 's)
;;如果要异步 (require 'async) 调用async-start
;;重新载入~/.emacs.d/elpa-25.2
;;(mapcar '(lambda (dir) (add-to-list 'load-path dir) )  (directory-files "~/.emacs.d/elpa-25.2" t "^\\([^.]\\|\\.[^.]\\|\\.\\..\\)") )

(defun zdefun-delete7zfile (dir) 
  "删除指定文件夹的7z压缩包"
  (mapcar #'(lambda (filename) 
              (f-delete filename) ) 
          (directory-files dir t ".7z$")))
(defun zdefun-7zdir(dir todir suffix encryption &optional password) 
  "压缩指定目录文件夹"
  (mapcar #'(lambda (filename) 
              (cond ((and 
                      (f-directory? filename) 
                      (not (s-ends-with? ".svn" filename t))
                      (not (s-ends-with? ".git" filename t))
                      (not (f-exists? (concat todir "/" (f-filename filename)  suffix)))) 
                     (progn  (print (concat "正在压缩" filename))
                             (cond ((or (s-equals? suffix ".7z") (s-equals? suffix ".zip"))
                                    (zdefun-7z filename (concat todir "/" (f-filename filename) suffix)  encryption password))
                                   ((s-equals? suffix ".exe")
                                    (zdefun-7zexe filename (concat todir "/" (f-filename filename) suffix)  encryption password)))
                             )))) 
          (directory-files dir  t "^\\([^.]\\|\\.[^.]\\|\\.\\..\\)")))
(defun zdefun-7zfile(dir todir encryption &optional password) 
  "压缩指定目录文件夹"
  (mapcar #'(lambda (filename) 
              (cond ((and 
                      (f-file? filename) 
                      (not (s-ends-with? ".7z" filename t)) 
                      (not (s-ends-with? ".zip" filename t)) 
                      (not (s-ends-with? ".rar" filename t)) 
                      (not (f-exists? (concat todir "/" (f-filename filename) ".7z")))) 
                     (progn  (print (concat "正在压缩" filename))
                             (zdefun-7z filename (concat todir "/" (f-filename filename) ".7z") encryption password)
                             )))) 
          (directory-files dir  t )))
(defun zdefun-un7zfile(dir todir encryption &optional password) 
  "解压指定目录文件夹"
  (mapcar #'(lambda (filename) 
              (cond ((s-ends-with? ".7z" filename t) 
                     (progn  (print (concat "正在解压" filename)) 
                             (zdefun-un7z filename todir encryption password)
                             )))) 
          (directory-files dir  t "^\\([^.]\\|\\.[^.]\\|\\.\\..\\)")))

(defun zdefun-un7z(filename todir encryption &optional password) 
  "解压文件"
  (if (not encryption)
      (shell-command (concat "7z.exe x " filename " -o\"" todir "\""))
    (shell-command (concat "7z.exe x " filename  " -p" password " -o\"" todir "\"")))
  )
(defun zdefun-7z(filename 7zfilename  encryption &optional password) 
  "压缩文件"
  (if (not encryption)
      (shell-command (concat "7z.exe a " 7zfilename " -mx0  \"" filename "\""))
    (shell-command (concat "7z.exe a " 7zfilename  " -p" password " -mx=0 -mhe=on \"" filename "\"")) )
  )
(defun zdefun-7zexe(filename 7zfilename  encryption &optional password) 
  "压缩文件"
  (if (not encryption)
      (shell-command (concat "7z.exe a -sfx " 7zfilename " \"" filename "\""))
    (shell-command (concat "7z.exe a -sfx " 7zfilename  " -p" password " -mhe=on \"" filename "\"")) )
  )


;;(setq gitdir "D:/zhangl/zrep/znote-gitee")
;;(setq svndir "D:/zhangl/zrep/znote")
;;(setq revsdir "/db/revs/0")
;;(setq gitrevsdir (concat gitdir revsdir))
;;(setq svnrevsdir (concat svndir revsdir))
;;
;;;;(format-time-string "%Y-%m-%d")
;;(if (f-exists? gitdir )
;;    (let ((bakdir (concat gitdir "-bak" )))
;;      (cond ( (f-exists? bakdir) ( f-delete bakdir t) ))
;;      (f-copy gitdir bakdir)
;;      )
;;  (progn (shell-command "git config --global user.name \"zhangl\"")
;;     (shell-command "git config --global user.email \"zdefun@aliyun.com\"")
;;     ())
;;  )
;;编程设置
(require 'init-program)
;;(zdefun-delete7zfile gitrevsdir )
;;(zdefun-7zfile svnrevsdir gitrevsdir t)


(provide 'init-zdefun)
