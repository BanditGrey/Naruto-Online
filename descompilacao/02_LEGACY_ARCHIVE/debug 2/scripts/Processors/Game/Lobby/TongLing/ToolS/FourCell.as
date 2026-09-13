package Processors.Game.Lobby.TongLing.ToolS
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TBB_Exp;
   import Logics.DatebaseVO.VO.TBB_Status;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TONGLINGANIMAL;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_INHERITPRACTICE;
   import Resources.Strings.STRING_TONGLING;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class FourCell
   {
      
      protected static const TongLingFastStrone:uint = CONST_INVENTORY.CATEGORYSECOND_TongLingFastStrone;
      
      protected var FObjMov:MovieClip = null;
      
      protected var FObjMsg:Object = null;
      
      protected var FPicBtm:Bitmap;
      
      protected var FisOpenThis:int = 0;
      
      protected var FSimpleBtn:SimpleButton;
      
      protected var FLevelScr:MovieClip;
      
      protected var FLevelScr_text:TextField;
      
      protected var FScr:MovieClip;
      
      protected var FSpeed:MovieClip;
      
      protected var FOneKeySpeed:MovieClip;
      
      protected var FCancel:MovieClip;
      
      protected var FExp:TextField;
      
      protected var FGetAginExp:TextField;
      
      protected var FBar:MovieClip;
      
      protected var FPic:MovieClip;
      
      protected var FName:TextField;
      
      protected var FMode:TextField;
      
      protected var FTime:TextField;
      
      protected var FIsDraging:int = 0;
      
      protected var FLittleCell:MovieClip;
      
      protected var FIsCanRefleash:Boolean = false;
      
      protected var FCellIndexGodle:int = 0;
      
      protected var FOpenLevel:int;
      
      public var FEndTime:uint;
      
      public var FGetExp:int;
      
      protected var FTrain:TBB_Status;
      
      protected var statu:TBB_Exp;
      
      protected var FCurCell:int;
      
      protected var FCanSure:TextField;
      
      protected var FFSpeed:Function;
      
      protected var FFOneKeySpeed:Function;
      
      protected var FIsCanSpeed:int = 0;
      
      protected var FIsCanGet:int = 0;
      
      protected var FRent:TUIComponent;
      
      protected var FPopWindow:TUIWindowConfirmation;
      
      protected var FPopWindowSpeed:TUIWindowConfirmation;
      
      protected var FPopWindowOneKeySpeed:TUIWindowConfirmation;
      
      protected var ObjVecs:Vector.<Object>;
      
      protected var FTuTime:int = 0;
      
      protected var allExp:int = 0;
      
      protected var Fmove:Function;
      
      protected var Fover:Function;
      
      protected var Fout:Function;
      
      protected var speed_Over1:Function;
      
      protected var speed_Move1:Function;
      
      protected var speed_Out1:Function;
      
      public var FIsCanClick:int = 0;
      
      protected var StateScr:String = "";
      
      public function FourCell()
      {
         super();
         this.FPicBtm = new Bitmap();
      }
      
      public function setMovObj(param1:MovieClip, param2:int, param3:TUIComponent, param4:Vector.<Object>, param5:int) : void
      {
         this.FRent = param3;
         this.FObjMov = param1;
         this.FCurCell = param2;
         this.ObjVecs = param4;
         this.FTuTime = param5;
         this.FCellIndexGodle = param2 + 6;
         this.Component();
         this.setNull();
      }
      
      public function setMsgObj(param1:Object) : void
      {
         this.FObjMsg = param1;
         if(param1 == null)
         {
            this.FIsDraging = 0;
            return;
         }
         this.FEndTime = param1.endtime;
         this.FTrain = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,this.FObjMsg.id) as TBB_Status;
         this.statu = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Exp,this.FObjMsg.id) as TBB_Exp;
         var _loc2_:Array = this.statu.LvArr;
         this.allExp = _loc2_[this.FObjMsg.level];
         this.value();
         this.FScr.visible = false;
         this.FIsDraging = 1;
         this.FExp.text = this.FObjMsg.CurExp + "/" + this.allExp;
         this.FBar.scaleX = Number(this.FObjMsg.CurExp) / Number(this.allExp);
      }
      
      public function get NameStr() : String
      {
         return this.FTrain.Name;
      }
      
      protected function value() : void
      {
         this.FName.text = this.FTrain.Name + " " + STRING_COMMON.FORMAT_Level + this.FObjMsg.level;
         this.FMode.text = this.FObjMsg.Scr;
         this.FGetExp = this.FObjMsg.AllExp;
         this.FCanSure.text = STRING_TONGLING.TONGLING_CanCEL_PEOYANG;
         this.FIsCanGet = 0;
         this.FIsCanRefleash = true;
         this.FSpeed.visible = true;
         this.FOneKeySpeed.visible = true;
      }
      
      public function UpdatePic() : void
      {
         if(this.FObjMsg == null)
         {
            this.FPicBtm.bitmapData = null;
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_Pet,this.FPicBtm,CONST_MODULES.MODULE_TongLing,this.FTrain.SmPic,1);
         if(this.FIsCanRefleash)
         {
            this.reflashTime();
         }
      }
      
      protected function Component() : void
      {
         this.FPopWindow = new TUIWindowConfirmation(this.FRent);
         this.FPopWindow.OnOK = this.PopWindowOnOk;
         this.FPopWindow.x = CONST_COMMON.STAGE_Width - this.FPopWindow.WindowWidth >> 1;
         this.FPopWindow.y = CONST_COMMON.STAGE_Height - this.FPopWindow.WindowHeight >> 1;
         TUtilityUIWindow.SetupWindowConfirmation(this.FPopWindow);
         this.FPopWindow.visible = false;
         this.FPopWindowSpeed = new TUIWindowConfirmation(this.FRent);
         this.FPopWindowSpeed.OnOK = this.PopWindowOnOkspeed;
         this.FPopWindowSpeed.x = CONST_COMMON.STAGE_Width - this.FPopWindowSpeed.WindowWidth >> 1;
         this.FPopWindowSpeed.y = CONST_COMMON.STAGE_Height - this.FPopWindowSpeed.WindowHeight >> 1;
         TUtilityUIWindow.SetupWindowConfirmation(this.FPopWindowSpeed);
         this.FPopWindowSpeed.visible = false;
         this.FPopWindowOneKeySpeed = new TUIWindowConfirmation(this.FRent);
         this.FPopWindowOneKeySpeed.OnOK = this.PopWindowOnOkOneKeySpeed;
         this.FPopWindowOneKeySpeed.x = CONST_COMMON.STAGE_Width - this.FPopWindowOneKeySpeed.WindowWidth >> 1;
         this.FPopWindowOneKeySpeed.y = CONST_COMMON.STAGE_Height - this.FPopWindowOneKeySpeed.WindowHeight >> 1;
         TUtilityUIWindow.SetupWindowConfirmation(this.FPopWindowOneKeySpeed);
         this.FPopWindowOneKeySpeed.visible = false;
         this.FPopWindowOneKeySpeed.SetCheckBox(true);
         this.FSimpleBtn = this.FObjMov[CONST_TONGLINGANIMAL.TONGLING_02_BUY] as SimpleButton;
         this.FLevelScr = this.FObjMov[CONST_TONGLINGANIMAL.TONGLING_02_SCRLEVEL] as MovieClip;
         this.FLevelScr_text = this.FObjMov[CONST_TONGLINGANIMAL.TONGLING_02_SCRLEVEL]["TT_Text"] as TextField;
         this.FLevelScr_text.mouseEnabled = false;
         this.FScr = this.FObjMov["M_scr"] as MovieClip;
         this.FLittleCell = this.FObjMov[CONST_TONGLINGANIMAL.TONGLING_02_ANIMAL] as MovieClip;
         this.FSpeed = this.FObjMov[CONST_TONGLINGANIMAL.TONGLING_02_ANIMAL][CONST_TONGLINGANIMAL.TONGLING_02_ANIMAL_SPEED] as MovieClip;
         this.FOneKeySpeed = this.FObjMov[CONST_TONGLINGANIMAL.TONGLING_02_ANIMAL][CONST_TONGLINGANIMAL.TONGLING_02_ANIMAL_SPEED_OneKey] as MovieClip;
         this.FCancel = this.FObjMov[CONST_TONGLINGANIMAL.TONGLING_02_ANIMAL][CONST_TONGLINGANIMAL.TONGLING_02_ANIMAL_CANCEL] as MovieClip;
         this.FExp = this.FObjMov[CONST_TONGLINGANIMAL.TONGLING_02_ANIMAL][CONST_TONGLINGANIMAL.TONGLING_02_ANIMAL_EXP] as TextField;
         this.FGetAginExp = this.FObjMov[CONST_TONGLINGANIMAL.TONGLING_02_ANIMAL]["TT_exp"] as TextField;
         this.FBar = this.FObjMov[CONST_TONGLINGANIMAL.TONGLING_02_ANIMAL][CONST_TONGLINGANIMAL.TONGLING_02_ANIMAL_BAR] as MovieClip;
         this.FPic = this.FObjMov[CONST_TONGLINGANIMAL.TONGLING_02_ANIMAL][CONST_TONGLINGANIMAL.TONGLING_02_ANIMAL_PIC] as MovieClip;
         this.FName = this.FObjMov[CONST_TONGLINGANIMAL.TONGLING_02_ANIMAL][CONST_TONGLINGANIMAL.TONGLING_02_ANIMAL_NAME] as TextField;
         this.FMode = this.FObjMov[CONST_TONGLINGANIMAL.TONGLING_02_ANIMAL][CONST_TONGLINGANIMAL.TONGLING_02_ANIMAL_MODE] as TextField;
         this.FTime = this.FObjMov[CONST_TONGLINGANIMAL.TONGLING_02_ANIMAL][CONST_TONGLINGANIMAL.TONGLING_02_ANIMAL_TIME] as TextField;
         this.FCanSure = TextField(this.FObjMov[CONST_TONGLINGANIMAL.TONGLING_02_ANIMAL][CONST_TONGLINGANIMAL.TONGLING_02_ANIMAL_CANCEL]["TText"]);
         TGameUtil.setButtonMode(this.FSpeed,true);
         TGameUtil.setButtonMode(this.FOneKeySpeed,true);
         TGameUtil.setButtonMode(this.FCancel,true);
         this.FScr.mouseEnabled = false;
         this.FLevelScr.mouseEnabled = false;
         this.FPic.addChild(this.FPicBtm);
         this.addEvent();
      }
      
      protected function addEvent() : void
      {
         this.FSimpleBtn.addEventListener(MouseEvent.CLICK,this.BtnClick);
         this.FSpeed.addEventListener(MouseEvent.CLICK,this.speedClick);
         this.FOneKeySpeed.addEventListener(MouseEvent.CLICK,this.OneKeySpeedClick);
         this.FSpeed.addEventListener(MouseEvent.MOUSE_OVER,this.Fspeed_Over);
         this.FSpeed.addEventListener(MouseEvent.MOUSE_MOVE,this.Fspeed_Move);
         this.FSpeed.addEventListener(MouseEvent.MOUSE_OUT,this.Fspeed_Out);
         this.FCancel.addEventListener(MouseEvent.CLICK,this.cancelClick);
         this.FPic.addEventListener(MouseEvent.MOUSE_MOVE,this.moveC);
         this.FPic.addEventListener(MouseEvent.MOUSE_OUT,this.outC);
         this.FPic.addEventListener(MouseEvent.MOUSE_OVER,this.overC);
      }
      
      public function get Mov() : MovieClip
      {
         return this.FObjMov;
      }
      
      public function Fspeed_Over(param1:MouseEvent) : void
      {
         if(this.FObjMsg == null)
         {
            return;
         }
         if(this.speed_Over1 != null)
         {
            this.speed_Over1();
         }
      }
      
      public function Fspeed_Move(param1:MouseEvent) : void
      {
         if(this.FObjMsg == null)
         {
            return;
         }
         if(this.speed_Move1 != null)
         {
            this.speed_Move1();
         }
      }
      
      public function Fspeed_Out(param1:MouseEvent) : void
      {
         if(this.FObjMsg == null)
         {
            return;
         }
         if(this.speed_Out1 != null)
         {
            this.speed_Out1();
         }
      }
      
      public function set _Over(param1:Function) : void
      {
         this.speed_Over1 = param1;
      }
      
      public function set _Move(param1:Function) : void
      {
         this.speed_Move1 = param1;
      }
      
      public function set _Out(param1:Function) : void
      {
         this.speed_Out1 = param1;
      }
      
      public function moveC(param1:MouseEvent) : void
      {
         if(this.FObjMsg == null)
         {
            return;
         }
         this.Fmove();
      }
      
      public function outC(param1:MouseEvent) : void
      {
         this.Fout();
      }
      
      public function overC(param1:MouseEvent) : void
      {
         if(this.FObjMsg == null)
         {
            return;
         }
         this.Fover(this.FObjMsg);
      }
      
      public function set move(param1:Function) : void
      {
         this.Fmove = param1;
      }
      
      public function set over(param1:Function) : void
      {
         this.Fover = param1;
      }
      
      public function set out(param1:Function) : void
      {
         this.Fout = param1;
      }
      
      protected function reflashTime() : void
      {
         var _loc3_:int = 0;
         var _loc1_:uint = uint(STimingCore.GetServerTick());
         var _loc2_:Number = this.FEndTime - _loc1_;
         if(_loc2_ < 0)
         {
            this.FIsCanSpeed = 1;
            _loc2_ = 0;
            _loc1_ = this.FEndTime;
            this.FCanSure.text = STRING_TONGLING.TONGLING_LINGQU;
            this.FIsCanGet = 1;
            this.FIsCanRefleash = false;
            this.FTime.text = TGameUtil.fomatTime(_loc2_);
            this.FGetAginExp.text = String(this.FGetExp);
            this.FSpeed.visible = false;
            this.FOneKeySpeed.visible = false;
            return;
         }
         this.FIsCanSpeed = 0;
         this.FTime.text = TGameUtil.fomatTime(_loc2_);
         _loc3_ = (Number(int(this.FObjMsg.allTime) * 60) - _loc2_) / Number(int(this.FObjMsg.allTime) * 60) * this.FGetExp;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         this.FGetAginExp.text = String(_loc3_);
      }
      
      public function setNull() : void
      {
         this.FIsCanRefleash = false;
         this.FObjMsg == null;
         this.FName.text = "";
         this.FMode.text = "";
         this.FTime.text = "00:00:00";
         this.FExp.text = "";
         this.FGetAginExp.text = "";
         this.FBar.scaleX = 1;
         this.FSpeed.visible = false;
         this.FOneKeySpeed.visible = false;
         this.FIsCanGet = 0;
      }
      
      public function set Speed(param1:Function) : void
      {
         this.FFSpeed = param1;
      }
      
      public function set OneKeySpeed(param1:Function) : void
      {
         this.FFOneKeySpeed = param1;
      }
      
      public function speedClick(param1:MouseEvent) : void
      {
         if(this.FObjMsg == null || this.FIsCanSpeed == 1 || Boolean(this.FIsCanClick))
         {
            return;
         }
         this.FIsCanClick = 1;
         this.StateScr = this.FCanSure.text;
         this.FFSpeed(this.FCurCell,1,this.StateScr,this.FObjMsg.Identifier0,this.FObjMsg.Identifier1);
      }
      
      public function PopWindowOnOkspeed(param1:Object = null) : void
      {
         this.FFSpeed(this.FCurCell,2,this.StateScr,this.FObjMsg.Identifier0,this.FObjMsg.Identifier1);
      }
      
      public function OneKeySpeedClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TInventories = null;
         var _loc5_:TInventory = null;
         var _loc6_:uint = 0;
         var _loc7_:Number = NaN;
         if(this.FObjMsg == null || this.FIsCanSpeed == 1 || Boolean(this.FIsCanClick))
         {
            return;
         }
         if(this.FPopWindowOneKeySpeed.IsSelected)
         {
            this.PopWindowOnOkOneKeySpeed();
            return;
         }
         _loc4_ = SLogicsCore.Character.Appliances;
         _loc3_ = uint(_loc4_.Count);
         _loc6_ = 0;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_ = _loc4_.GetInventoryByIndex(_loc2_);
            if(_loc5_.CategorySecond == TongLingFastStrone)
            {
               _loc6_ += _loc5_.Quantity;
            }
            _loc2_++;
         }
         _loc7_ = Math.max(0,(this.FEndTime - STimingCore.GetServerTick() - 1) / this.FTuTime / 60) + 1;
         this.FPopWindowOneKeySpeed.Text = TUtilityString.Format(STRING_TONGLING.TONGLING_59,int(_loc7_),_loc6_);
         this.FPopWindowOneKeySpeed.Visible = true;
      }
      
      public function PopWindowOnOkOneKeySpeed(param1:Object = null) : void
      {
         this.FIsCanClick = 1;
         this.FFOneKeySpeed(this.FCurCell,2,this.StateScr,this.FObjMsg.Identifier0,this.FObjMsg.Identifier1);
      }
      
      public function cancelClick(param1:MouseEvent) : void
      {
         if(this.FObjMsg == null)
         {
            return;
         }
         this.StateScr = this.FCanSure.text;
         if(this.StateScr == STRING_TONGLING.TONGLING_CanCEL_PEOYANG)
         {
            this.FPopWindowSpeed.Text = STRING_TONGLING.TONGLING_6;
            this.FPopWindowSpeed.visible = true;
         }
         else
         {
            this.PopWindowOnOkspeed();
         }
      }
      
      public function BtnClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         _loc2_ = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_TongLing_Buy).DescribeString,this.ObjVecs[1]);
         this.FPopWindow.Text = _loc2_;
         this.FPopWindow.visible = true;
      }
      
      public function PopWindowOnOk(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TongLingOpenLocation_Rep);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FCurCell + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      public function set setSimpleBtn(param1:Boolean) : void
      {
         this.FSimpleBtn.visible = param1;
      }
      
      public function set setLevelScr(param1:Boolean) : void
      {
         this.FLevelScr.visible = param1;
      }
      
      public function set setLevelScrText(param1:int) : void
      {
         this.FOpenLevel = param1;
         this.FLevelScr_text.text = TUtilityString.Format(STRING_TONGLING.TONGLING_NEW_0,param1);
      }
      
      public function get setLevelScrText() : int
      {
         return this.FOpenLevel;
      }
      
      public function set setScr(param1:Boolean) : void
      {
         this.FScr.visible = param1;
      }
      
      public function set setLittle(param1:Boolean) : void
      {
         this.FLittleCell.visible = param1;
      }
      
      public function get Msg() : Object
      {
         return this.FObjMsg;
      }
      
      public function set Msg(param1:Object) : void
      {
         this.FObjMsg = param1;
      }
      
      public function set isOpenThis(param1:int) : void
      {
         this.FisOpenThis = param1;
      }
      
      public function get isOpenThis() : int
      {
         return this.FisOpenThis;
      }
      
      public function set Draging(param1:int) : void
      {
         this.FIsDraging = param1;
      }
      
      public function set CellIndexGodle(param1:int) : void
      {
         this.FCellIndexGodle = param1;
      }
      
      public function get CellIndexGodle() : int
      {
         return this.FCellIndexGodle;
      }
      
      public function get Draging() : int
      {
         return this.FIsDraging;
      }
      
      public function set CanRefleash(param1:Boolean) : void
      {
         this.FIsCanRefleash = param1;
      }
      
      public function addTime() : void
      {
         this.FEndTime -= this.FTuTime * 60;
      }
      
      public function SetEndTime(param1:uint) : void
      {
         this.FEndTime = param1;
      }
      
      public function get IsCanGet() : int
      {
         return this.FIsCanGet;
      }
      
      public function getStr(param1:int) : String
      {
         var _loc2_:String = STRING_INHERITPRACTICE.INHERIT_GOLD;
         switch(param1)
         {
            case 0:
               _loc2_ = STRING_INHERITPRACTICE.INHERIT_SILVER_COIN;
               break;
            case 2:
               _loc2_ = STRING_INHERITPRACTICE.INHERIT_GOLD;
               break;
            case 3:
               _loc2_ = STRING_INHERITPRACTICE.INHERIT_GOLD;
         }
         return _loc2_;
      }
   }
}

