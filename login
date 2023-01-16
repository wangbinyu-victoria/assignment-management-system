// pages/login/login.js
Page({
    data: {
        picList:[],
        Sno:'',
        Tno:'',
        password:'',
        T_password:'',
        selectIndex:0,
        tabs:[
            {
                id:0,
                name:'学生',
            },
            {
                id:1,
                name:'教师',
            }
        ]
    },

    onShow(){

    },
    handleUpload(){
        var picList = []
        wx.chooseImage({
          count: 1,
        }).then(res=>{
            wx.cloud.uploadFile({
                cloudPath:'testImg/Shopping_Bag.png',
                filePath:res.tempFilePaths[0],
                success:res=>{
                    console.log(res)
                }
            })
        })


        
    },

    handleLogin(){
        if (this.data.selectIndex === 0) {
            var Data = {
                Sno:this.data.Sno,
                password:this.data.password
            }
            this.login({name:'login_student',data:Data,page:'home',userInfo:this.data.Sno,identity:'student'})
        }
        else{
            var Data = {
                Tno:this.data.Tno,
                password:this.data.T_password
            }
            this.login({name:'login_teacher',data:Data,page:'home_teacher',userInfo:this.data.Tno,identity:'teacher'})
        }
    },

    handleRegister(){
        wx.navigateTo({
          url: '/pages/register/register'
        })
    },

    getSelectIndex(e){
        this.setData({
            selectIndex:e.detail.index
        })
    },

    login({name, data, page,userInfo,identity}){
        wx.cloud.callFunction({
            name:name,
            data:data
        }).then(res=>{
            console.log(res)
            if (res.result === 1) {
                wx.setStorageSync('userInfo', userInfo)
                wx.setStorageSync('identity', identity)
                wx.setStorageSync('isLogin',true)
                wx.reLaunch({
                  url: '/pages/'+page+'/'+page,
                })
            }
            else if(res.result === 0){
                wx.showToast({
                  title: '不存在该账号',
                  duration:2000,
                  mask:true,
                  icon:'error'
                })
            }
            else{
                wx.showToast({
                    title: '密码错误',
                    duration:2000,
                    mask:true,
                    icon:'error'
                  })
            }
        })
    },

    handleShowPassword(){
        this.setData({
            showPassword:!this.data.showPassword
        })
    }

})
