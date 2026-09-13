package Processors.Game.Lobby.TongLing
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.UI.TUICore;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TBB_AttriBute;
   import Logics.DatebaseVO.VO.TBB_Drop;
   import Logics.DatebaseVO.VO.TBB_Exp;
   import Logics.DatebaseVO.VO.TBB_Status;
   import Logics.SLogicsCore;
   import Logics.TongLing.TTongLingData;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Overlayers.TongLingAnimal.TongLingIntroTip;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_TONGLINGANIMAL;
   import Resources.Strings.STRING_TONGLING;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TPressorTongLingAnimal extends TProcessorLobbyWindow
   {
      
      protected var FRoot_Mvc:MovieClip;
      
      protected var FMesObj:Object = null;
      
      protected var FIntroTip:TongLingIntroTip;
      
      protected var FUICom:TUIComponent;
      
      protected var FExteShow:Function;
      
      protected var FromText:TextField;
      
      protected var FHeadBmp:Bitmap;
      
      protected var FUIcore:TUICore;
      
      protected var FTbb:TBB_Status;
      
      protected var TPopWindow:TUIWindowConfirmation;
      
      protected var isFrom:int = 0;
      
      public function TPressorTongLingAnimal(param1:TUIComponent, param2:TUICore)
      {
         super(param1);
         this.FHeadBmp = new Bitmap();
         this.FUICom = param1;
         this.FUIcore = param2;
      }
      
      public function SetRoot(param1:MovieClip) : void
      {
         this.FRoot_Mvc = param1;
         this.addSatuBtn();
         this.addEvent();
         this.FIntroTip = new TongLingIntroTip(this.FUICom);
         this.FIntroTip.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FIntroTip);
         MovieClip(this.FRoot_Mvc["Pic"]["Pic"]).addChild(this.FHeadBmp);
         this.TPopWindow = new TUIWindowConfirmation(this.FUICom);
         this.TPopWindow.OnOK = this.PopWindowOnOk;
         this.TPopWindow.x = CONST_COMMON.STAGE_Width - this.TPopWindow.WindowWidth >> 1;
         this.TPopWindow.y = CONST_COMMON.STAGE_Height - this.TPopWindow.WindowHeight >> 1;
         TUtilityUIWindow.SetupWindowConfirmation(this.TPopWindow);
         this.TPopWindow.visible = false;
      }
      
      protected function addEvent() : void
      {
         MovieClip(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_DROP]).addEventListener(MouseEvent.CLICK,this.BtnClick);
         MovieClip(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_FRMO]).addEventListener(MouseEvent.CLICK,this.BtnClick);
         this.FromText = this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_FRMO]["MC_From_text"] as TextField;
         MovieClip(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_INTRO]).addEventListener(MouseEvent.MOUSE_OVER,this.IntroEvent);
         MovieClip(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_INTRO]).addEventListener(MouseEvent.MOUSE_OUT,this.OutEvent);
         MovieClip(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_INTRO]).addEventListener(MouseEvent.MOUSE_MOVE,this.MoveEvent);
      }
      
      protected function addSatuBtn() : void
      {
         TGameUtil.setButtonMode(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_DROP],true);
         TGameUtil.setButtonMode(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_FRMO],true);
      }
      
      public function SetMsg(param1:Object) : void
      {
         this.FMesObj = param1;
         if(param1 == null)
         {
            this.FHeadBmp.bitmapData = null;
            TextField(this.FRoot_Mvc["mc_name"]).text = "";
            TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_EXPBAR]["TF_Level_1"]).text = "";
            MovieClip(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_XIEZHU]).visible = false;
            this.setNull();
            return;
         }
         this.FTbb = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,this.FMesObj.Id) as TBB_Status;
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_EXPBAR][CONST_TONGLINGANIMAL.TONGLING_01_EXPBAR_LEVEL]).text = param1.Level;
         TextField(this.FRoot_Mvc["mc_name"]).text = this.FTbb.Name;
         this.Attrit();
         this.exp();
         if(param1.Status == 1)
         {
            this.FromText.text = STRING_TONGLING.TONGLING_CanCEL_from;
            this.isFrom = 0;
         }
         else
         {
            this.FromText.text = STRING_TONGLING.TONGLING_from;
            this.isFrom = 1;
         }
      }
      
      protected function setNull() : void
      {
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["TF_Text0"]).text = "";
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["TF_Text1"]).text = "";
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["TF_Text2"]).text = "";
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["TF_Text3"]).text = "";
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["TF_Text4"]).text = "";
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["TF_Text5"]).text = "";
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["TF_Text0"]).text = "";
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["TF_Text1"]).text = "";
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["TF_Text2"]).text = "";
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["TF_Text3"]).text = "";
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["TF_Text4"]).text = "";
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["TF_Text5"]).text = "";
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["TT_00"]).text = "";
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["TT_01"]).text = "";
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["TT_02"]).text = "";
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["TT_03"]).text = "";
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["TT_04"]).text = "";
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["TT_05"]).text = "";
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["TT_00"]).text = "";
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["TT_01"]).text = "";
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["TT_02"]).text = "";
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["TT_03"]).text = "";
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["TT_04"]).text = "";
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["TT_05"]).text = "";
         MovieClip(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["MC_meizi"]).gotoAndStop(1);
         MovieClip(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["MC_meizi"]).gotoAndStop(2);
         MovieClip(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_EXPBAR][CONST_TONGLINGANIMAL.TONGLING_01_EXPBAR_BAR]).scaleX = 0;
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_EXPBAR][CONST_TONGLINGANIMAL.TONGLING_01_EXPBAR_EXP]).text = "0/0";
      }
      
      public function Updatet() : void
      {
         if(this.FMesObj == null)
         {
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_Pet,this.FHeadBmp,CONST_MODULES.MODULE_TongLing,this.FTbb.SmPic,2);
      }
      
      public function Attrit() : void
      {
         var _loc1_:TBB_Status = null;
         var _loc2_:TBB_AttriBute = null;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,this.FMesObj.Id) as TBB_Status;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_AttriBute,this.FMesObj.Id) as TBB_AttriBute;
         var _loc3_:String = _loc2_.LvArr[this.FMesObj.Level - 1];
         _loc3_ = _loc3_.substring(1,_loc3_.length - 1);
         var _loc4_:Array = _loc3_.split(",");
         if(this.FMesObj.Level >= _loc1_.EvoLevel)
         {
            this.AttritLast(_loc4_);
         }
         else
         {
            MovieClip(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]).visible = true;
            MovieClip(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["MC_meizi"]).gotoAndStop(1);
            MovieClip(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["MC_meizi"]).gotoAndStop(2);
            this.RenderAttr01(_loc4_);
            _loc5_ = _loc2_.LvArr[this.FMesObj.Level];
            if(_loc5_ == "[]")
            {
               _loc5_ = _loc2_.LvArr[this.FMesObj.Level - 1];
            }
            _loc5_ = _loc5_.substring(1,_loc5_.length - 1);
            _loc6_ = _loc5_.split(",");
            this.RenderAttr02(_loc6_);
         }
         MovieClip(this.FRoot_Mvc["MC_Pinzhi"]).gotoAndStop(_loc1_.Rarity);
         this.IsMainVice();
      }
      
      protected function AttritLast(param1:Array) : void
      {
         MovieClip(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]).visible = false;
         MovieClip(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["MC_meizi"]).gotoAndStop(1);
         this.RenderAttr02(param1);
      }
      
      public function IsMainVice() : void
      {
         var _loc1_:int = int(this.FMesObj.Position);
         if(_loc1_ == 0)
         {
            MovieClip(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_XIEZHU]).visible = false;
            return;
         }
         if(_loc1_ == 1)
         {
            MovieClip(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_XIEZHU]).visible = true;
            MovieClip(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_XIEZHU]).gotoAndStop(2);
         }
         else
         {
            MovieClip(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_XIEZHU]).visible = true;
            MovieClip(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_XIEZHU]).gotoAndStop(1);
         }
      }
      
      public function RenderAttr01(param1:Array) : void
      {
         var _loc2_:TTongLingData = null;
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["TF_Text0"]).text = param1[0];
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["TF_Text1"]).text = param1[1];
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["TF_Text2"]).text = param1[2];
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["TF_Text3"]).text = param1[3];
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["TF_Text4"]).text = param1[4];
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["TF_Text5"]).text = param1[5];
         _loc2_ = SLogicsCore.TongLingDatas.GetTongLingDataById64(this.FMesObj.Identifier0,this.FMesObj.Identifier1);
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["TT_00"]).text = String(_loc2_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_NearAttack));
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["TT_01"]).text = String(_loc2_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_NearDefense));
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["TT_02"]).text = String(_loc2_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_StrategyAttack));
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["TT_03"]).text = String(_loc2_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_StrategyDefense));
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["TT_04"]).text = String(_loc2_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_Speed));
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER]["TT_05"]).text = String(_loc2_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_MAXHP));
      }
      
      public function RenderAttr02(param1:Array) : void
      {
         var _loc2_:TTongLingData = null;
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["TF_Text0"]).text = param1[0];
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["TF_Text1"]).text = param1[1];
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["TF_Text2"]).text = param1[2];
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["TF_Text3"]).text = param1[3];
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["TF_Text4"]).text = param1[4];
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["TF_Text5"]).text = param1[5];
         _loc2_ = SLogicsCore.TongLingDatas.GetTongLingDataById64(this.FMesObj.Identifier0,this.FMesObj.Identifier1);
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["TT_00"]).text = String(_loc2_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_NearAttack));
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["TT_01"]).text = String(_loc2_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_NearDefense));
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["TT_02"]).text = String(_loc2_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_StrategyAttack));
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["TT_03"]).text = String(_loc2_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_StrategyDefense));
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["TT_04"]).text = String(_loc2_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_Speed));
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_CHARACTER1]["TT_05"]).text = String(_loc2_.GetWashAttributeByType(CONST_COMMON.BASEATTRIBUTENAME_MAXHP));
      }
      
      public function exp() : void
      {
         var _loc1_:TBB_Exp = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Exp,this.FMesObj.Id) as TBB_Exp;
         var _loc2_:Array = _loc1_.LvArr;
         var _loc3_:int = int(_loc2_[this.FMesObj.Level]);
         var _loc4_:int = int(this.FMesObj.CurExp);
         if(_loc4_ > _loc3_)
         {
            _loc4_ = _loc3_;
         }
         MovieClip(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_EXPBAR][CONST_TONGLINGANIMAL.TONGLING_01_EXPBAR_BAR]).scaleX = _loc4_ / _loc3_;
         TextField(this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_EXPBAR][CONST_TONGLINGANIMAL.TONGLING_01_EXPBAR_EXP]).text = _loc4_ + "/" + _loc3_;
      }
      
      public function BtnClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_DROP]:
               this.DropBtn();
               break;
            case this.FRoot_Mvc[CONST_TONGLINGANIMAL.TONGLING_01_FRMO]:
               this.FramBtn();
         }
      }
      
      protected function FramBtn() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         if(this.FMesObj == null)
         {
            return;
         }
         if(this.isFrom == 0)
         {
            _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TongLing_from_Rep);
         }
         else
         {
            _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TongLingFrom_Rep);
         }
         _loc2_ = _loc1_.Data;
         var _loc3_:uint = uint(this.FMesObj.Identifier0);
         var _loc4_:uint = uint(this.FMesObj.Identifier1);
         _loc2_.writeUnsignedInt(_loc3_);
         _loc2_.writeUnsignedInt(_loc4_);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function PopWindowOnOk(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(this.FMesObj == null)
         {
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TongLingDrop_Rep);
         _loc3_ = _loc2_.Data;
         var _loc4_:uint = uint(this.FMesObj.Identifier0);
         var _loc5_:uint = uint(this.FMesObj.Identifier1);
         _loc3_.writeUnsignedInt(_loc4_);
         _loc3_.writeUnsignedInt(_loc5_);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function DropBtn() : void
      {
         if(this.FMesObj == null)
         {
            return;
         }
         if(this.FMesObj.PosPeiYang != 0)
         {
            this.FExteShow(STRING_TONGLING.TONGLING_7);
            return;
         }
         if(this.FMesObj.Position != 0)
         {
            this.FExteShow(STRING_TONGLING.TONGLING_8);
            return;
         }
         if(this.FMesObj.Status != 0)
         {
            this.FExteShow(STRING_TONGLING.TONGLING_9);
            return;
         }
         var _loc1_:TBB_Drop = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Drop,this.FMesObj.Id) as TBB_Drop;
         var _loc2_:Array = _loc1_.LvArr;
         var _loc3_:int = int(_loc2_[this.FMesObj.Level - 1]);
         var _loc4_:String = STRING_TONGLING.TONGLING_3;
         _loc2_ = _loc4_.split("&");
         this.TPopWindow.Text = _loc2_[0] + _loc3_ + _loc2_[1];
         this.TPopWindow.visible = true;
      }
      
      public function IntroEvent(param1:MouseEvent) : void
      {
         if(this.FMesObj == null)
         {
            return;
         }
         this.FIntroTip.Context = this.FMesObj.Id;
         this.FIntroTip.Render(this.FUIcore.MouseCoordinate);
         this.FIntroTip.Show();
      }
      
      public function OutEvent(param1:MouseEvent) : void
      {
         this.FIntroTip.Hide();
      }
      
      public function MoveEvent(param1:MouseEvent) : void
      {
         this.FIntroTip.Render(this.FUIcore.MouseCoordinate);
      }
      
      public function set ExteShow(param1:Function) : void
      {
         this.FExteShow = param1;
      }
   }
}

