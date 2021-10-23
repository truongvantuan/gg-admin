package ggadmin.dto;

import ggadmin.model.ums.Admin;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminDto {

    @NotNull
    private String username;

    @NotNull
    private String password;

    @Email
    private String email;

    public Admin toAdmin() {
        Admin admin = new Admin();
        admin.setPassword(this.password);
        admin.setUsername(this.username);
        admin.setEmail(this.email);
        return admin;
    }
}
