package Processors.Game.Lobby.LostShenqi.OtherPanel
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.DatebaseVO.VO.TMazeaward;
   import Logics.LostShenQi.TLostShenQiLogicData;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TongLing.ToolS.Tools_Help;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_LOSTSHENQI;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessoriShenQiMiGongDiTu extends TProcessorLobbyWindow
   {
      
      public static const SHIER:int = 12;
      
      protected var FThisPanel:MovieClip;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FMC_LiKaiBtn:MovieClip;
      
      protected var mcv:MovieClip;
      
      protected var FMC_BuyBtn:MovieClip;
      
      protected var FMC_BuyBtn2:MovieClip;
      
      protected var FMC_BuyBtn3:MovieClip;
      
      protected var FTF_XingDongDian:TextField;
      
      protected var FTF_MianFeiTiaoGuoCiShu:TextField;
      
      protected var FTF_BianGengCiShu:TextField;
      
      protected var FTF_MiGongJiFen:TextField;
      
      protected var FTF_JadeNum:TextField;
      
      protected var FTF_NextLevelDec:TextField;
      
      protected var FT_SilverCoin:TextField = null;
      
      protected var FT_Gold:TextField = null;
      
      protected var FT_Coupon:TextField = null;
      
      protected var FIsInilization:Boolean;
      
      protected var FLostShenQiLogicData:TLostShenQiLogicData;
      
      protected var FMiGongSinglenGeZi:Vector.<MiGongSinglenGeZi>;
      
      protected var FMC_Role:MovieClip;
      
      protected var FMC_Role_Little:MovieClip;
      
      protected var FMC_RoleEffect:MovieClip;
      
      protected var FMC_OverLabel:MovieClip;
      
      protected var FBuyBackFunction:Function;
      
      protected var FBackFucntion:Function;
      
      public function TProcessoriShenQiMiGongDiTu(param1:TUIComponent)
      {
         super(param1);
         this.FMiGongSinglenGeZi = new Vector.<MiGongSinglenGeZi>(SHIER * SHIER);
         this.FLostShenQiLogicData = SLogicsCore.LostShenQiLogicData;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MiGongSinglenGeZi = null;
         var _loc5_:int = 0;
         var _loc6_:TBaseHero = null;
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_LostMiGong") as MovieClip;
         addChild(this.FThisPanel);
         this.FThisPanel.x = (FUICore.StageWidth - this.FThisPanel.width) / 2;
         this.FThisPanel.y = (FUICore.StageHeight - this.FThisPanel.height) / 2;
         this.FBTN_Close = this.FThisPanel["BTN_Close"];
         this.FMC_LiKaiBtn = this.FThisPanel["MC_LiKaiBtn"];
         TGameUtil.setButtonMode(this.FMC_LiKaiBtn,true);
         this.FMC_BuyBtn = this.FThisPanel["MC_BuyBtn"];
         TGameUtil.setButtonMode(this.FMC_BuyBtn,true);
         this.FMC_BuyBtn2 = this.FThisPanel["MC_BuyBtn2"];
         TGameUtil.setButtonMode(this.FMC_BuyBtn2,true);
         this.FMC_BuyBtn3 = this.FThisPanel["MC_BuyBtn3"];
         TGameUtil.setButtonMode(this.FMC_BuyBtn3,true);
         new Tools_Help(Parent,this.FThisPanel["Btn_Infor"],70170092,FUICore);
         this.FT_SilverCoin = this.FThisPanel["FT_SilverCoin"];
         this.FT_Gold = this.FThisPanel["FT_Gold"];
         this.FT_Coupon = this.FThisPanel["FT_Coupon"];
         this.FTF_XingDongDian = this.FThisPanel["TF_XingDongDian"];
         this.FTF_MianFeiTiaoGuoCiShu = this.FThisPanel["TF_MianFeiTiaoGuoCiShu"];
         this.FTF_BianGengCiShu = this.FThisPanel["TF_BianGengCiShu"];
         this.FTF_MiGongJiFen = this.FThisPanel["TF_MiGongJiFen"];
         this.FTF_JadeNum = this.FThisPanel["TF_JadeNum"];
         this.FTF_NextLevelDec = this.FThisPanel["TF_NextLevelDec"];
         this.mcv = this.FThisPanel["MC_GeZiMiddle"];
         this.FMC_Role = this.mcv["MC_Role"];
         this.FMC_RoleEffect = this.mcv["MC_RoleEffect"];
         this.FMC_OverLabel = this.mcv["MC_OverLabel"];
         this.FMC_Role.mouseEnabled = false;
         this.FMC_Role.mouseChildren = false;
         this.FMC_RoleEffect.mouseEnabled = false;
         this.FMC_RoleEffect.mouseChildren = false;
         this.FMC_OverLabel.mouseEnabled = false;
         this.FMC_OverLabel.mouseChildren = false;
         this.FMC_Role["mc_effect"].play();
         this.FMC_Role_Little = this.FMC_Role["mc_role"];
         _loc2_ = 0;
         while(_loc2_ < SHIER)
         {
            _loc3_ = 0;
            while(_loc3_ < SHIER)
            {
               _loc4_ = new MiGongSinglenGeZi();
               _loc4_.ThisMc = this.mcv["MC_" + _loc2_ + "_" + _loc3_];
               this.FMiGongSinglenGeZi[_loc2_ * SHIER + _loc3_] = _loc4_;
               _loc4_.CurFream = 1;
               _loc4_.BackFucntion = this.BackFucntionClick;
               _loc3_++;
            }
            _loc2_++;
         }
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,SLogicsCore.Character.MainHero.Identifier) as TBaseHero;
         _loc5_ = _loc6_.Profession;
         _loc2_ = _loc6_.Sex;
         this.FMC_Role.gotoAndStop(_loc5_ + "" + _loc2_);
         this.FMC_Role_Little = this.FMC_Role["mc_role"];
         this.FMC_Role_Little.gotoAndStop(2);
         this.FIsInilization = true;
         this.SheDingWeiZi();
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.FMC_LiKaiBtn.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.FMC_BuyBtn.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.FMC_BuyBtn2.addEventListener(MouseEvent.CLICK,this.HandleClick);
         this.FMC_BuyBtn3.addEventListener(MouseEvent.CLICK,this.HandleClick);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         super.LogicsPerform();
         if(!this.FIsInilization)
         {
            return;
         }
         if(!this.Visible)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < SHIER * SHIER)
         {
            this.FMiGongSinglenGeZi[_loc1_].UpdateImage();
            _loc1_++;
         }
         this.updateMoney();
      }
      
      public function updateMoney() : void
      {
         this.FT_SilverCoin.text = SLogicsCore.Character.CreditSilverCoin.ToString();
         this.FT_Gold.text = SLogicsCore.Character.CreditGold.toString();
         this.FT_Coupon.text = SLogicsCore.Character.CreditGiftCertificate.toString();
      }
      
      public function OpenThisPanel() : void
      {
         this.UpdateView();
      }
      
      public function UpdateViewCopy() : void
      {
         var _loc1_:TMazeaward = null;
         if(!this.FIsInilization)
         {
            return;
         }
         this.FTF_MianFeiTiaoGuoCiShu.text = this.FLostShenQiLogicData.ShengYuTiaoGuoCiShu.toString();
         this.FTF_BianGengCiShu.text = this.FLostShenQiLogicData.ShengYuBianGengCiShu.toString();
         this.FTF_XingDongDian.text = this.FLostShenQiLogicData.XingDongDianShu.toString();
         this.FTF_MiGongJiFen.text = this.FLostShenQiLogicData.MiGongJiFen.toString();
         this.FTF_JadeNum.text = this.FLostShenQiLogicData.DangQianMiGongKeHuoDeiJadeNum.toString();
         _loc1_ = SLogicsCore.LostShenQiLogicData.GetXiaDangJiFen;
         this.FTF_NextLevelDec.text = TUtilityString.Format(STRING_LOSTSHENQI.str14,_loc1_.EventPoint,_loc1_.AwardLostpiece);
      }
      
      public function UpdateView() : void
      {
         this.UpdateViewCopy();
         this.ChuLiRoleWeiZi();
      }
      
      public function ChuLiRoleWeiZi() : void
      {
         var _loc1_:MiGongSinglenGeZi = null;
         var _loc2_:int = 0;
         var _loc3_:MiGongSinglenGeZi = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         if(!this.FIsInilization)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < SHIER * SHIER)
         {
            _loc3_ = this.FMiGongSinglenGeZi[_loc2_];
            _loc3_.IsCanClick = false;
            _loc2_++;
         }
         _loc1_ = this.GetGeZiByXY(this.FLostShenQiLogicData.CurPosition_X,this.FLostShenQiLogicData.CurPosition_Y);
         this.FMC_Role.x = _loc1_.ThisMc.x;
         this.FMC_Role.y = _loc1_.ThisMc.y;
         _loc4_ = _loc1_.CurX;
         _loc5_ = _loc1_.CurY;
         _loc6_ = _loc1_.CurX;
         _loc7_ = _loc1_.CurY;
         if(_loc6_ > 0)
         {
            _loc6_--;
            _loc1_ = this.GetGeZiByXY(_loc6_,_loc7_);
            _loc1_.IsCanClick = true;
         }
         _loc6_ = _loc4_;
         if(_loc6_ < 11)
         {
            _loc6_++;
            _loc1_ = this.GetGeZiByXY(_loc6_,_loc7_);
            _loc1_.IsCanClick = true;
         }
         _loc6_ = _loc4_;
         if(_loc7_ > 0)
         {
            _loc7_--;
            _loc1_ = this.GetGeZiByXY(_loc6_,_loc7_);
            _loc1_.IsCanClick = true;
         }
         _loc7_ = _loc5_;
         if(_loc7_ < 11)
         {
            _loc7_++;
            _loc1_ = this.GetGeZiByXY(_loc6_,_loc7_);
            _loc1_.IsCanClick = true;
         }
      }
      
      protected function SheDingWeiZi() : void
      {
         var _loc1_:MiGongSinglenGeZi = null;
         _loc1_ = this.GetGeZiByXY(this.FLostShenQiLogicData.OverPosition[0],this.FLostShenQiLogicData.OverPosition[0]);
         this.FMC_OverLabel.x = _loc1_.ThisMc.x;
         this.FMC_OverLabel.y = _loc1_.ThisMc.y;
         _loc1_ = this.GetGeZiByXY(this.FLostShenQiLogicData.BeginPosition[0],this.FLostShenQiLogicData.BeginPosition[0]);
         this.FMC_RoleEffect.x = _loc1_.ThisMc.x;
         this.FMC_RoleEffect.y = _loc1_.ThisMc.y;
      }
      
      public function PACKETID_S2C_MAZE_Get_Event_Info(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:MiGongSinglenGeZi = null;
         var _loc7_:MiGongSinglenGeZi = null;
         _loc3_ = 0;
         while(_loc3_ < SHIER * SHIER)
         {
            _loc7_ = this.FMiGongSinglenGeZi[_loc3_];
            _loc7_.CurShiJianId = 0;
            _loc3_++;
         }
         _loc2_ = param1.readShort();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readUnsignedInt();
            _loc5_ = param1.readUnsignedInt();
            _loc6_ = this.GetGeZiByXY(_loc4_,_loc5_);
            _loc6_.CurShiJianId = param1.readUnsignedInt();
            _loc3_++;
         }
         this.ChuLiRoleWeiZi();
      }
      
      public function PACKETID_S2C_MAZE_Moved_Position(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MiGongSinglenGeZi = null;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         if(this.FLostShenQiLogicData.ShiFouYiQingChuMiWu)
         {
            _loc2_ = 0;
            while(_loc2_ < SHIER * SHIER)
            {
               _loc3_ = this.FMiGongSinglenGeZi[_loc2_];
               _loc3_.CurFream = 2;
               _loc2_++;
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < SHIER * SHIER)
            {
               _loc3_ = this.FMiGongSinglenGeZi[_loc2_];
               _loc3_.CurFream = 1;
               _loc2_++;
            }
            _loc4_ = param1.readShort();
            _loc2_ = 0;
            while(_loc2_ < _loc4_)
            {
               _loc5_ = param1.readUnsignedInt();
               _loc6_ = param1.readUnsignedInt();
               this.SetMiWuByXY(_loc5_,_loc6_);
               _loc2_++;
            }
         }
         this.ChuLiRoleWeiZi();
      }
      
      protected function SetMiWuByXY(param1:uint, param2:uint) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:MiGongSinglenGeZi = null;
         _loc3_ = param1;
         _loc4_ = param2;
         _loc6_ = this.GetGeZiByXY(param1,param2);
         _loc6_.CurFream = 2;
         if(param1 > 0)
         {
            param1--;
            _loc6_ = this.GetGeZiByXY(param1,param2);
            _loc6_.CurFream = 2;
            _loc4_ = param2;
            if(param2 > 0)
            {
               param2--;
               _loc6_ = this.GetGeZiByXY(param1,param2);
               _loc6_.CurFream = 2;
            }
            param2 = _loc4_;
            if(param2 < 11)
            {
               param2++;
               _loc6_ = this.GetGeZiByXY(param1,param2);
               _loc6_.CurFream = 2;
            }
         }
         param1 = _loc3_;
         _loc6_ = this.GetGeZiByXY(param1,param2);
         _loc6_.CurFream = 2;
         param2 = _loc4_;
         if(param2 > 0)
         {
            param2--;
            _loc6_ = this.GetGeZiByXY(param1,param2);
            _loc6_.CurFream = 2;
         }
         param2 = _loc4_;
         if(param2 < 11)
         {
            param2++;
            _loc6_ = this.GetGeZiByXY(param1,param2);
            _loc6_.CurFream = 2;
         }
         param1 = _loc3_;
         if(param1 < 11)
         {
            param1++;
            param2 = _loc4_;
            _loc6_ = this.GetGeZiByXY(param1,param2);
            _loc6_.CurFream = 2;
            if(param2 > 0)
            {
               param2--;
               _loc6_ = this.GetGeZiByXY(param1,param2);
               _loc6_.CurFream = 2;
            }
            param2 = _loc4_;
            if(param2 < 11)
            {
               param2++;
               _loc6_ = this.GetGeZiByXY(param1,param2);
               _loc6_.CurFream = 2;
            }
         }
      }
      
      protected function GetGeZiByXY(param1:uint, param2:uint) : MiGongSinglenGeZi
      {
         var _loc3_:int = 0;
         var _loc4_:MiGongSinglenGeZi = null;
         _loc3_ = 0;
         while(_loc3_ < SHIER * SHIER)
         {
            _loc4_ = this.FMiGongSinglenGeZi[_loc3_];
            if(_loc4_.CurX == param1 && _loc4_.CurY == param2)
            {
               break;
            }
            _loc3_++;
         }
         return _loc4_;
      }
      
      protected function HandleClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FBTN_Close:
            case this.FMC_LiKaiBtn:
               if(FOnClose != null)
               {
                  FOnClose();
               }
               break;
            case this.FMC_BuyBtn:
               if(!this.FMC_BuyBtn.buttonMode)
               {
                  return;
               }
               if(this.FBuyBackFunction != null)
               {
                  this.FBuyBackFunction(2,2);
               }
               break;
            case this.FMC_BuyBtn2:
               if(!this.FMC_BuyBtn2.buttonMode)
               {
                  return;
               }
               if(this.FBuyBackFunction != null)
               {
                  this.FBuyBackFunction(0,4);
               }
               break;
            case this.FMC_BuyBtn3:
               if(!this.FMC_BuyBtn3.buttonMode)
               {
                  return;
               }
               if(this.FBuyBackFunction != null)
               {
                  this.FBuyBackFunction(1,5);
               }
         }
      }
      
      public function set BuyBackFunction(param1:Function) : void
      {
         this.FBuyBackFunction = param1;
      }
      
      public function set BackFucntion(param1:Function) : void
      {
         this.FBackFucntion = param1;
      }
      
      protected function BackFucntionClick(param1:uint, param2:uint) : void
      {
         if(this.FBackFucntion != null)
         {
            this.FBackFucntion(param1,param2);
         }
      }
      
      public function SetFangXiang(param1:int) : void
      {
         if(!this.FMC_Role_Little)
         {
            return;
         }
         this.FMC_Role_Little.gotoAndStop(param1);
      }
   }
}

