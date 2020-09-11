import 'package:permission/permission.dart';

class PermissionModel {
  PermissionName permission = PermissionName.Storage;

  Future<bool> checkPermissionStatus() async {
    List<PermissionName> permissions = [];
    permissions.add(permission);
    PermissionStatus status;
    List<Permissions> permissions2 =
        await Permission.getPermissionsStatus(permissions);
    permissions2.forEach((element) {
      status = element.permissionStatus;
    });

    if (status == PermissionStatus.allow) {
      return Future<bool>.value(true);
    } else if (status == PermissionStatus.deny ||
        status == PermissionStatus.notDecided) {
      return Future<bool>.value(false);
    }
  }

  Future<void> requestPermission() async {
    List<PermissionName> permissions = [];
    permissions.add(permission);
    Permission.requestPermissions(permissions);
  }
}