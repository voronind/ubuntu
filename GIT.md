Source: https://habr.com/ru/company/manychat/blog/511946/

- Модель форка.  
  `origin` - свой форк для пулл-реквестов.  
  `upstream` - основной репозиторий, доступный только для чтения.  
  Удаляем свой master, чтобы не мешался.
  ```bash
  git branch -D master  
  ```

- Вместо `git pull`
  ```bash
  git fetch --all
  git rebase feature upstream/master
  ```
  
- Вместо `git push -f`
  ```console
  git push origin +feature
  ```
  
- Вместо `git checkout -b feature`
  ```console
  git fetch --all
  git checkout -b feature upstream/master
  ```
  
- Коммит для будущего фиксапа
  ```console
  > git commit -m "Feature A is done"
  > git commit -m "Feature B is done"
  > git commit --fixup=fe2f857
  >
  > git log --oneline
  a5050e7 fixup! Feature A is done
  633e33f Feature B is done
  fe2f857 Feature A is done
  ...
  > git rebase -i --autosquash cb5db88
  ```

TODO
----
- алиас чтобы запушить мастер и теги
- алиас чтобы удалить ветку и ремоут
