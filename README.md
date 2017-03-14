# KeyChainDemo
iOS设备中的keyChain是一个安全的存储容器，可以用来为不同应用保存敏感信息（用户名，密码，网络密码等）。同时，keyChain是一个相对独立的空间，当应用替换或删除时并不会删除keyChain的内容，目前看来，使用keyChain来保存用户名和用户密码是最优的解决方案。

本例本着简单易用的原则，提供了一些账号信息常用的增、删、改、查功能
//保存或更新
[GZKeyChain saveUserName:@"张三" pwd:@"asdfghjkl"];
[GZKeyChain saveUserName:@"lisi" pwd:@"asrtyui"];
[GZKeyChain saveUserName:@"张三" pwd:@"rtghnm,loi"];//会覆盖先前密码

//查询所有用户的账号密码
NSDictionary *dic = [GZKeyChain loadAccountInfo];
NSLog(@"dic = %@",dic);

//查询某一用户的账号密码
NSString *pwd = [GZKeyChain loadPwdForUserName:@"lisi"];
NSLog(@"userPwd = %@",pwd);

//删除某一用户的账号密码
[GZKeyChain removeForUserName:@"张三"];
NSLog(@"dic1 = %@",[GZKeyChain loadAccountInfo]);

//删除所有用户的账号密码
[GZKeyChain removeAll];
NSLog(@"dic2 = %@",[GZKeyChain loadAccountInfo]);
