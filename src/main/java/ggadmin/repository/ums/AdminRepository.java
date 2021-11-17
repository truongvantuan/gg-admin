package ggadmin.repository.ums;

import ggadmin.model.ums.Admin;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Date;
import java.util.List;
import java.util.Optional;


public interface AdminRepository extends JpaRepository<Admin, Long>, JpaSpecificationExecutor<Admin> {

    Optional<Admin> getAdminByUsername(String username);

    /**
     * hàm cập nhật thời gian đăng nhập gần đây nhất
     *
     * @param dateLogin thời gian đăng nhập
     * @param username  tên Admin đăng nhập
     */
    @Modifying
    @Query(value = "UPDATE Admin ad SET ad.loginTime = :date WHERE ad.username = :username")
    void saveLoginTime(@Param("date") Date dateLogin, @Param("username") String username);

    @Query("SELECT a FROM Admin a")
    List<Admin> selectAllAdmin();

    Page<Admin> findAllByUsernameContainingIgnoreCase(String keyword, Pageable page);
}
