package com.bookland.demobookland.services;

import com.bookland.demobookland.model.Admin;
import com.bookland.demobookland.repository.AdminRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;

@Service
public class AdminServices {
    @Autowired
    private AdminRepository adminRepository;

    public Admin getAdmin() {
        //Admin admin = (Admin) adminRepository.findAllById(Collections.singleton(0));
        List<Admin> adminList = new ArrayList<>();
        for (Admin admin : adminRepository.findAll()) {
            String line = admin.toString();
            boolean isFoundMail = line.indexOf("adminBookLand2020@gmail.com") !=-1? true: false;
            boolean isFoundPass = line.indexOf("040420") !=-1? true: false;
            if  (isFoundMail & isFoundPass ){
                adminList.add(admin);
            }

        }
        return (Admin) adminList.get(0);
        //return admin;
    }

    @Transactional
    public Admin saveAdmin(Admin admin) {
        return adminRepository.save(admin);
    }

}



