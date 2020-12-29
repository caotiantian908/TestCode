import  json
class ResourceDevice:
    #代表所有测试资源设备的配置类， 字段动态定义
    def __init__(self, name="", *args, **kwargs):
        self.name = name
        self.type = kwargs.get("type", None)
        self.description = kwargs.get("description", None)
        self.ports = dict()
    def add_port(self, name, *args, **kwargs):
        if name in self.ports:
            raise ResourceError(f"Port Name {name} already exists")
        self.ports[f"{name}"] = DevicePort()

class DevicePort:
    # 代表设备的连接端口
    def __init__(self, parent_device=None, name="", *args, **kwargs):
        self.parent = parent_device
        self.name = name
        self.description = kwargs.get("description", None)
        self.remote_ports = list()
    def to_dict(self):
        ret = dict()
        for key, value in self.__dict__.items():
            if key == "parent":
                ret[key] = value.name
            elif key == "remote_ports":
                ret[key] = list()
                for remote_port in value:
                    #使用device的名称和port的名称来表示远端的端口
                    #在反序列化的时候可以方便的找到相应的对象实例
                    pirnt(remote_port)
                    ret[key].append(
                        {
                            "device": remote_port.parent.name,
                            "port": remote_port.name
                        }
                    )
            else:
                ret[key] = value
        return  ret

if __name__ == '__main__':

    R = ResourceDevice()
    R.add_port('ETH1')
    d = json.dumps(R, default=lambda o:o.__dict__)
    print(d)
