package Processors.Game.Lobby.Shortcuts.Window
{
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Registries.*;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TBB_Status;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Mentorship.Elements.TDisciple;
   import Logics.Mentorship.TMentorship;
   import Logics.TimeCoolDown.*;
   import Logics.Unlocks.*;
   import Processors.Game.Lobby.Common.Shortcuts.*;
   import Processors.Game.Windows.Information.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Windows.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class TWindowConstantly extends TUIComponent
   {
      
      protected static const STATE_HIDE:int = 0;
      
      protected static const STATE_RUNNING:int = 1;
      
      protected static const STATE_ColdDown:int = 0;
      
      protected static const STATE_Colding:int = 1;
      
      public static const MillisecondsPerSecond:int = 1000;
      
      public static const MillisecondsPerMinute:int = 1000 * 60;
      
      public static const MillisecondsPerHour:int = 1000 * 60 * 60;
      
      public static const TYPE_Function_Strengthen:uint = CONST_SHORTCUTS.TYPE_Function_Strengthen;
      
      public static const TYPE_Activity_Arena:uint = CONST_SHORTCUTS.TYPE_Activity_Arena;
      
      public static const TYPE_Activity_Slave:uint = CONST_SHORTCUTS.TYPE_Activity_Slave;
      
      public static const TYPE_Function_TongLing:uint = CONST_SHORTCUTS.TYPE_Function_TongLing;
      
      public static const TYPE_Constantly_Strengthen:uint = CONST_SHORTCUTS.TYPE_Constantly_Strengthen;
      
      public static const TYPE_Constantly_Arena:uint = CONST_SHORTCUTS.TYPE_Constantly_Arena;
      
      public static const TYPE_Constantly_BigDipper:uint = CONST_SHORTCUTS.TYPE_Constantly_BigDipper;
      
      public static const TYPE_Constantly_Slave:uint = CONST_SHORTCUTS.TYPE_Constantly_Slave;
      
      public static const TYPE_Constantly_TongLing:uint = CONST_SHORTCUTS.TYPE_Constantly_TongLing;
      
      protected static const Index_Position:int = 0;
      
      protected static const Index_Location:int = 1;
      
      protected static const Index_Type:int = 2;
      
      protected static const ConstantlyYOffset:int = 20;
      
      public static const CHANGEREDMINUTETIME:int = 20;
      
      protected var FUIConstantlys:Vector.<MovieClip>;
      
      protected var FUIConstantlyArrows:Vector.<SimpleButton>;
      
      protected var FTFConstantlysLable:Vector.<TextField>;
      
      protected var FTFConstantlysTime:Vector.<TextField>;
      
      protected var FConstantlysState:Vector.<int>;
      
      protected var FTimers:Vector.<TTimeCoolDown>;
      
      protected var FVisibleContorlGlobal:Vector.<Boolean>;
      
      protected var FVisibleContorlLocation:Vector.<Boolean>;
      
      protected var FRoutinesTextClick:TRegistryRoutine;
      
      protected var FRoutinesTailClick:TRegistryRoutine;
      
      protected var FPromotWindow:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FHint_ClearTime:THint;
      
      protected var FWidth:int;
      
      protected var FSeverStarOpenLevel:int;
      
      protected var FMentorshipOpenLevel:int;
      
      protected var FInitCompleted:Boolean;
      
      protected var FOnOpenFunctionWindow:Function;
      
      protected var FOnOpenActivityWindow:Function;
      
      protected var FOnOpenBigDipperWindow:Function;
      
      protected var FOnStrengthenClearCD:Function;
      
      protected var FOnArenaClearCD:Function;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOut:Function;
      
      public function TWindowConstantly(param1:TUIComponent)
      {
         super(param1);
         this.RegistryRoutines();
         this.FWidth = 0;
      }
      
      public function Perform_UIDispatch() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TConfigValue = null;
         this.FConstantlysState = new Vector.<int>(CONST_SHORTCUTS.CONSTANTLY_NUM);
         this.FUIConstantlys = new Vector.<MovieClip>();
         this.FTFConstantlysLable = new Vector.<TextField>();
         this.FTFConstantlysTime = new Vector.<TextField>();
         this.FUIConstantlyArrows = new Vector.<SimpleButton>();
         _loc3_ = int(CONST_SHORTCUTS.CONSTANTLY_NUM);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = TUtilityReflection.CreateDisplayObjectInstance("mc_constantly") as MovieClip;
            addChild(_loc1_);
            this.FUIConstantlys.push(_loc1_);
            this.FUIConstantlyArrows.push(_loc1_["Btn_Cleartime"]);
            this.FTFConstantlysLable.push(_loc1_["TF_Lable1"]);
            this.FTFConstantlysTime.push(_loc1_["TF_Lable2"]);
            _loc1_ = _loc1_["icon"];
            _loc1_.gotoAndStop(_loc2_ + 1);
            _loc2_++;
         }
         this.FPromotWindow = new TUIWindowConfirmation(this.Parent);
         TUtilityUIWindow.SetupWindowConfirmation(this.FPromotWindow);
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2 - 20;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         this.UILocation();
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.SERVENSTAR_OPEN_LEVEL) as TConfigValue;
         this.FSeverStarOpenLevel = _loc4_.Value as uint;
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Slave_OpenLevel) as TConfigValue;
         this.FMentorshipOpenLevel = _loc4_.Value as uint;
      }
      
      protected function UILocation() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TextField = null;
         var _loc3_:SimpleButton = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TTimeCoolDown = null;
         this.FVisibleContorlGlobal = new Vector.<Boolean>(CONST_SHORTCUTS.CONSTANTLY_NUM);
         this.FVisibleContorlLocation = new Vector.<Boolean>(CONST_SHORTCUTS.CONSTANTLY_NUM);
         _loc1_ = 0;
         while(_loc1_ < CONST_SHORTCUTS.CONSTANTLY_NUM)
         {
            _loc2_ = this.FTFConstantlysLable[_loc1_];
            _loc2_.addEventListener(TextEvent.LINK,this.TextClicked);
            _loc2_ = this.FTFConstantlysTime[_loc1_];
            _loc2_.addEventListener(TextEvent.LINK,this.TextClicked);
            _loc3_ = this.FUIConstantlyArrows[_loc1_];
            _loc3_.addEventListener(MouseEvent.CLICK,this.ArrowClicked);
            _loc3_.addEventListener(MouseEvent.MOUSE_MOVE,this.ArrowMouseMove);
            _loc3_.addEventListener(MouseEvent.MOUSE_OUT,this.ArrowMouseOut);
            this.FConstantlysState[_loc1_] = STATE_RUNNING;
            this.FUIConstantlys[_loc1_].visible = false;
            this.FVisibleContorlGlobal[_loc1_] = false;
            this.FVisibleContorlLocation[_loc1_] = false;
            _loc1_++;
         }
         this.FPromotWindow.x = (CONST_COMMON.STAGE_Width - this.FPromotWindow.WindowWidth) / 2;
         this.FPromotWindow.y = (CONST_COMMON.STAGE_Height - this.FPromotWindow.WindowHeight) / 2;
         this.FHint_ClearTime = new THint();
         this.FHint_ClearTime.Caption = STRING_SHORTCUTS.HINT_CLEARTIME;
         this.FTimers = new Vector.<TTimeCoolDown>();
         _loc5_ = SLogicsCore.Character.TimeCoolDowns.GetDigestByIdentifier(CONST_COMMON.TIME_COOLDOWN_Strengthen);
         this.FTimers.push(_loc5_);
         _loc5_ = SLogicsCore.Character.TimeCoolDowns.GetDigestByIdentifier(CONST_COMMON.TIME_COOLDOWN_Arean);
         this.FTimers.push(_loc5_);
         this.FInitCompleted = true;
      }
      
      protected function RePosition() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < CONST_SHORTCUTS.CONSTANTLY_NUM)
         {
            _loc2_ = this.FUIConstantlys[_loc1_];
            _loc3_ = this.FConstantlysState[_loc1_];
            if(this.FVisibleContorlGlobal[_loc1_] && this.FVisibleContorlLocation[_loc1_])
            {
               _loc2_.y = _loc4_ * ConstantlyYOffset;
               _loc4_++;
            }
            _loc1_++;
         }
      }
      
      protected function RegistryRoutines() : void
      {
         this.FRoutinesTextClick = new TRegistryRoutine();
         this.FRoutinesTailClick = new TRegistryRoutine();
         this.FRoutinesTextClick.Register(CONST_SHORTCUTS.TYPE_Constantly_Strengthen,this.TextClick_Strengthen);
         this.FRoutinesTailClick.Register(CONST_SHORTCUTS.TYPE_Constantly_Strengthen,this.ArrowClick_Strengthen);
         this.FRoutinesTextClick.Register(CONST_SHORTCUTS.TYPE_Constantly_Arena,this.TextClick_Arena);
         this.FRoutinesTailClick.Register(CONST_SHORTCUTS.TYPE_Constantly_Arena,this.ArrowClick_Arena);
         this.FRoutinesTextClick.Register(CONST_SHORTCUTS.TYPE_Constantly_BigDipper,this.TextClick_BigDipper);
         this.FRoutinesTailClick.Register(CONST_SHORTCUTS.TYPE_Constantly_BigDipper,this.ArrowClick_BigDipper);
         this.FRoutinesTextClick.Register(CONST_SHORTCUTS.TYPE_Constantly_Slave,this.TextClick_Mentorship);
         this.FRoutinesTextClick.Register(CONST_SHORTCUTS.TYPE_Constantly_TongLing,this.TextClick_TongLing);
      }
      
      public function Update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         if(!this.FInitCompleted)
         {
            return;
         }
         _loc2_ = int(CONST_SHORTCUTS.CONSTANTLY_NUM);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc1_ == TYPE_Constantly_BigDipper)
            {
               this.UpdateBigDipper();
            }
            else if(_loc1_ == TYPE_Constantly_Slave)
            {
               this.UpdateMentorship();
            }
            else if(_loc1_ == TYPE_Constantly_TongLing)
            {
               this.UpdateTongLing();
            }
            else
            {
               this.UpdateByIndex(_loc1_);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBigDipper() : void
      {
         var _loc1_:TextField = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = int(SLogicsCore.BigDipperFreeTime);
         _loc2_ = TUtilityString.Format(STRING_SHORTCUTS.FORMAT_Constantlys[TYPE_Constantly_BigDipper * 3],"FF00",TYPE_Constantly_BigDipper.toString());
         if(_loc5_ > 0)
         {
            _loc3_ = TUtilityString.Format(STRING_SHORTCUTS.FORMAT_Constantlys[TYPE_Constantly_BigDipper * 3 + 1],TYPE_Constantly_BigDipper.toString());
         }
         else
         {
            _loc3_ = TUtilityString.Format(STRING_SHORTCUTS.FORMAT_Constantlys[TYPE_Constantly_BigDipper * 3 + 2],TYPE_Constantly_BigDipper.toString());
         }
         this.FUIConstantlyArrows[TYPE_Constantly_BigDipper].visible = false;
         _loc1_ = this.FTFConstantlysLable[TYPE_Constantly_BigDipper];
         _loc1_.htmlText = _loc2_;
         _loc1_ = this.FTFConstantlysTime[TYPE_Constantly_BigDipper];
         _loc1_.htmlText = _loc3_;
      }
      
      protected function UpdateMentorship() : void
      {
         var _loc1_:TMentorship = null;
         var _loc2_:TextField = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         _loc1_ = SLogicsCore.Mentorship;
         switch(_loc1_.Identity)
         {
            case CONST_MENTORSHIP.IDENTITY_Freedom:
               _loc3_ = STRING_SHORTCUTS.STRING_Freedom;
               _loc4_ = STRING_SHORTCUTS.STRING_Arrest;
               break;
            case CONST_MENTORSHIP.IDENTITY_Master:
               _loc3_ = STRING_SHORTCUTS.STRING_Master;
               if(this.CheckHasDisciple(_loc1_))
               {
                  _loc4_ = STRING_SHORTCUTS.STRING_Arrest;
               }
               else
               {
                  _loc4_ = STRING_SHORTCUTS.STRING_DiscipleWorking;
               }
               break;
            case CONST_MENTORSHIP.IDENTITY_Disciple:
               _loc3_ = STRING_SHORTCUTS.STRING_Disciple;
               if(_loc1_.TodayResistCount > 0)
               {
                  _loc4_ = STRING_SHORTCUTS.STRING_Resist;
               }
               else if(_loc1_.InteractionCDTime)
               {
                  _loc4_ = STRING_SHORTCUTS.STRING_InteractionCDTime;
               }
               else
               {
                  _loc4_ = STRING_SHORTCUTS.STRING_Working;
               }
         }
         _loc3_ = TUtilityString.Format(STRING_SHORTCUTS.FORMAT_ConstantlyMentorshipMainTittle,TYPE_Constantly_Slave,_loc3_);
         _loc4_ = TUtilityString.Format(STRING_SHORTCUTS.FORMAT_ConstantlyMentorshipMainTittle,TYPE_Constantly_Slave,_loc4_);
         this.FUIConstantlyArrows[TYPE_Constantly_Slave].visible = false;
         _loc2_ = this.FTFConstantlysLable[TYPE_Constantly_Slave];
         _loc2_.htmlText = _loc3_;
         _loc2_ = this.FTFConstantlysTime[TYPE_Constantly_Slave];
         _loc2_.htmlText = _loc4_;
      }
      
      protected function UpdateTongLing() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TextField = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:Object = null;
         var _loc12_:uint = 0;
         var _loc13_:TBB_Status = null;
         var _loc14_:uint = 0;
         _loc8_ = false;
         _loc9_ = false;
         _loc10_ = false;
         _loc14_ = 0;
         _loc6_ = SLogicsCore.TongLingData;
         _loc7_ = SLogicsCore.TongLingOpened;
         _loc4_ = STRING_SHORTCUTS.STRING_TongLing_Lable;
         _loc5_ = STRING_SHORTCUTS.STRING_TongLing_WaitTraining;
         _loc12_ = uint(STimingCore.GetServerTick());
         _loc1_ = 0;
         while(_loc1_ < _loc6_.length)
         {
            _loc11_ = _loc6_[_loc1_];
            _loc13_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,_loc11_.Id) as TBB_Status;
            if(Boolean(_loc11_.isPeiYang) && _loc11_.TimeOver <= _loc12_)
            {
               _loc8_ = true;
               break;
            }
            if(_loc11_.Level == _loc13_.EvoLevel && _loc13_.GetPoint != 0)
            {
               _loc9_ = true;
            }
            if(_loc11_.isPeiYang)
            {
               _loc14_++;
            }
            _loc1_++;
         }
         if(_loc6_.length > _loc14_ && _loc14_ < _loc7_.length)
         {
            _loc10_ = true;
         }
         if(_loc8_)
         {
            _loc5_ = STRING_SHORTCUTS.STRING_TongLing_TrainingCompleted;
         }
         else if(_loc9_)
         {
            _loc5_ = STRING_SHORTCUTS.STRING_TongLing_Evolution;
         }
         else if(_loc10_)
         {
            _loc5_ = STRING_SHORTCUTS.STRING_TongLing_WaitTraining;
         }
         else
         {
            _loc5_ = STRING_SHORTCUTS.STRING_TongLing_Training;
         }
         _loc4_ = TUtilityString.Format(STRING_SHORTCUTS.FORMAT_ConstantlyTongLingTittle,TYPE_Constantly_TongLing,_loc4_);
         _loc5_ = TUtilityString.Format(STRING_SHORTCUTS.FORMAT_ConstantlyTongLingTittle,TYPE_Constantly_TongLing,_loc5_);
         this.FUIConstantlyArrows[TYPE_Constantly_TongLing].visible = false;
         _loc3_ = this.FTFConstantlysLable[TYPE_Constantly_TongLing];
         _loc3_.htmlText = _loc4_;
         _loc3_ = this.FTFConstantlysTime[TYPE_Constantly_TongLing];
         _loc3_.htmlText = _loc5_;
      }
      
      protected function CheckHasDisciple(param1:TMentorship) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TDisciple = null;
         _loc3_ = param1.DiscipleList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = param1.DiscipleList[_loc2_];
            if(_loc4_ == null)
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      protected function UpdateByIndex(param1:int) : void
      {
         var _loc2_:TextField = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:TTimeCoolDown = null;
         var _loc7_:int = 0;
         if(this.FConstantlysState[param1] == STATE_HIDE)
         {
            return;
         }
         if(param1 >= this.FTimers.length)
         {
            _loc7_ = STATE_ColdDown;
         }
         else
         {
            _loc6_ = this.FTimers[param1];
            if(_loc6_.TimingTime <= 0)
            {
               _loc7_ = STATE_ColdDown;
            }
            else
            {
               _loc7_ = STATE_Colding;
            }
         }
         switch(_loc7_)
         {
            case STATE_ColdDown:
               _loc3_ = TUtilityString.Format(STRING_SHORTCUTS.FORMAT_Constantlys[param1 * 3],"FF00",param1.toString());
               _loc4_ = TUtilityString.Format(STRING_SHORTCUTS.FORMAT_Constantlys[param1 * 3 + 1],param1.toString());
               this.FUIConstantlyArrows[param1].visible = false;
               break;
            case STATE_Colding:
               _loc5_ = TGameUtil.fomatTime(_loc6_.TimingTime);
               _loc3_ = TUtilityString.Format(STRING_SHORTCUTS.FORMAT_Constantlys[param1 * 3],"FFFFFF",param1.toString());
               _loc4_ = TUtilityString.Format(this.GetColdingFormatStringByIndex(param1),param1.toString(),_loc5_);
               this.FUIConstantlyArrows[param1].visible = true;
         }
         _loc2_ = this.FTFConstantlysLable[param1];
         _loc2_.htmlText = _loc3_;
         _loc2_ = this.FTFConstantlysTime[param1];
         _loc2_.htmlText = _loc4_;
      }
      
      protected function GetColdingFormatStringByIndex(param1:int) : String
      {
         var _loc2_:String = null;
         var _loc3_:TTimeCoolDown = null;
         if(param1 == CONST_SHORTCUTS.TYPE_Constantly_Strengthen)
         {
            _loc3_ = this.FTimers[CONST_SHORTCUTS.TYPE_Constantly_Strengthen];
            if(_loc3_.TimingTime > CONST_SMITHY.CHANGEREDMINUTETIME * 60)
            {
               return STRING_SHORTCUTS.FORMAT_ConstantlyStrengthenCloding_Red;
            }
            return STRING_SHORTCUTS.FORMAT_ConstantlyStrengthenCloding_Black;
         }
         return STRING_SHORTCUTS.FORMAT_Constantlys[param1 * 3 + 2];
      }
      
      protected function TextClick_Strengthen() : void
      {
         if(this.FOnOpenFunctionWindow != null)
         {
            this.FOnOpenFunctionWindow(this,TYPE_Function_Strengthen,0);
         }
      }
      
      protected function ArrowClick_Strengthen() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TTimeCoolDown = null;
         _loc2_ = this.FTimers[CONST_SHORTCUTS.TYPE_Constantly_Strengthen];
         _loc1_ = Math.ceil(_loc2_.TimingTime / 60);
         var _loc3_:TCharacter = SLogicsCore.Character;
         if(_loc1_ > _loc3_.CreditGold + _loc3_.CreditGiftCertificate)
         {
            this.FUIWindowRecharge.visible = true;
            return;
         }
         this.OpenPromotWindow(_loc1_);
         this.FPromotWindow.OnOK = this.StrengthenClearTime;
      }
      
      protected function StrengthenClearTime(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SmithyStrengthClearTime);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function TextClick_Arena() : void
      {
         if(this.FOnOpenActivityWindow != null)
         {
            this.FOnOpenActivityWindow(this,TYPE_Activity_Arena,0);
         }
      }
      
      protected function ArrowClick_Arena() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TTimeCoolDown = null;
         _loc2_ = this.FTimers[CONST_SHORTCUTS.TYPE_Constantly_Arena];
         _loc1_ = Math.ceil(_loc2_.TimingTime / 60);
         var _loc3_:TCharacter = SLogicsCore.Character;
         if(_loc1_ > _loc3_.CreditGold + _loc3_.CreditGiftCertificate)
         {
            this.FUIWindowRecharge.visible = true;
            return;
         }
         this.OpenPromotWindow(_loc1_);
         this.FPromotWindow.OnOK = this.ArenaClearTime;
      }
      
      protected function ArenaClearTime(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Arena_Faster_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function TextClick_BigDipper() : void
      {
         if(this.FOnOpenBigDipperWindow != null)
         {
            this.FOnOpenBigDipperWindow(this,TYPE_Constantly_BigDipper);
         }
      }
      
      protected function ArrowClick_BigDipper() : void
      {
      }
      
      protected function TextClick_Mentorship() : void
      {
         if(this.FOnOpenActivityWindow != null)
         {
            this.FOnOpenActivityWindow(this,TYPE_Activity_Slave,0);
         }
      }
      
      protected function TextClick_TongLing() : void
      {
         if(this.FOnOpenFunctionWindow != null)
         {
            this.FOnOpenFunctionWindow(this,TYPE_Function_TongLing,2);
         }
      }
      
      protected function OpenPromotWindow(param1:int) : void
      {
         var _loc2_:String = null;
         _loc2_ = TUtilityString.Format(STRING_SHORTCUTS.FORMAT_ClearCD,param1);
         this.FPromotWindow.Text = _loc2_;
         this.FPromotWindow.visible = true;
      }
      
      protected function CheckHit(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:Vector.<int> = null;
         _loc5_ = CONST_SHORTCUTS.UnlockCommand;
         _loc4_ = int(_loc5_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc6_ = _loc5_[_loc3_];
            if(_loc6_[Index_Position] == param1 && _loc6_[Index_Location] == param2)
            {
               return _loc6_[Index_Type];
            }
            _loc3_++;
         }
         return -1;
      }
      
      protected function UpdateBounds() : void
      {
         if(!this.FInitCompleted)
         {
            return;
         }
         if(this.FInitCompleted)
         {
            this.FWidth = this.width;
         }
         else
         {
            this.FWidth = 0;
         }
      }
      
      protected function TextClicked(param1:TextEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Function = null;
         _loc2_ = int(param1.text);
         _loc3_ = this.FRoutinesTextClick.GetRoutineByIndentifier(_loc2_);
         _loc3_();
      }
      
      protected function ArrowClicked(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:SimpleButton = null;
         var _loc4_:Function = null;
         _loc3_ = param1.currentTarget as SimpleButton;
         _loc2_ = this.FUIConstantlyArrows.indexOf(_loc3_);
         _loc4_ = this.FRoutinesTailClick.GetRoutineByIndentifier(_loc2_);
         _loc4_();
      }
      
      protected function ArrowMouseMove(param1:MouseEvent) : void
      {
         if(this.FHintOnOver != null)
         {
            this.FHintOnOver(this,this.FHint_ClearTime);
         }
      }
      
      protected function ArrowMouseOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      public function get ShortcutWidth() : int
      {
         this.UpdateBounds();
         return this.FWidth;
      }
      
      public function set OnStrengthenClearCD(param1:Function) : void
      {
         this.FOnStrengthenClearCD = param1;
         this.FUIConstantlys[CONST_SHORTCUTS.TYPE_Constantly_Strengthen].visible = true;
      }
      
      public function set OnArenaClearCD(param1:Function) : void
      {
         this.FOnArenaClearCD = param1;
         this.FUIConstantlys[CONST_SHORTCUTS.TYPE_Constantly_Arena].visible = true;
      }
      
      public function set OnOpenFunctionWindow(param1:Function) : void
      {
         this.FOnOpenFunctionWindow = param1;
      }
      
      public function set OnOpenActivityWindow(param1:Function) : void
      {
         this.FOnOpenActivityWindow = param1;
      }
      
      public function get OnOpenBigDipperWindow() : Function
      {
         return this.FOnOpenBigDipperWindow;
      }
      
      public function set OnOpenBigDipperWindow(param1:Function) : void
      {
         this.FOnOpenBigDipperWindow = param1;
      }
      
      public function set HintOnOver(param1:Function) : void
      {
         this.FHintOnOver = param1;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function UnlockNotification(param1:TUnlock) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.CheckHit(param1.Position,param1.Localtion);
         if(_loc2_ != -1)
         {
            this.FConstantlysState[_loc2_] = STATE_RUNNING;
            this.FVisibleContorlLocation[_loc2_] = true;
            if(this.FVisibleContorlGlobal[_loc2_])
            {
               this.FUIConstantlys[_loc2_].visible = true;
            }
         }
         this.RePosition();
      }
      
      public function CheckUnlockSeverStar() : void
      {
         if(SLogicsCore.Character.GetMainLevel() >= this.FSeverStarOpenLevel)
         {
            this.FConstantlysState[TYPE_Constantly_BigDipper] = STATE_RUNNING;
            this.FVisibleContorlLocation[TYPE_Constantly_BigDipper] = true;
            if(this.FVisibleContorlGlobal[TYPE_Constantly_BigDipper])
            {
               this.FUIConstantlys[TYPE_Constantly_BigDipper].visible = true;
            }
         }
         this.RePosition();
      }
      
      public function UpdateShortcutsState(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUnlock = null;
         var _loc5_:TUnlocks = null;
         _loc5_ = param1 as TUnlocks;
         _loc2_ = 0;
         while(_loc2_ < CONST_SHORTCUTS.CONSTANTLY_NUM)
         {
            this.FVisibleContorlLocation[_loc2_] = false;
            this.FUIConstantlys[_loc2_].visible = false;
            _loc2_++;
         }
         _loc3_ = _loc5_.Count;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = _loc5_.GetUnlockByIndex(_loc2_);
            if(_loc4_.State == TUnlock.UNLOCKSTATE_Unlocked)
            {
               this.UnlockNotification(_loc4_);
            }
            _loc2_++;
         }
         if(SLogicsCore.Character.GetMainLevel() >= this.FSeverStarOpenLevel)
         {
            this.FConstantlysState[TYPE_Constantly_BigDipper] = STATE_RUNNING;
            this.FVisibleContorlLocation[TYPE_Constantly_BigDipper] = true;
            if(this.FVisibleContorlGlobal[TYPE_Constantly_BigDipper])
            {
               this.FUIConstantlys[TYPE_Constantly_BigDipper].visible = true;
            }
         }
         this.RePosition();
      }
      
      public function ShortcutsSetup(param1:TLobbyShortcutConstantlyModes) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         if(!this.FInitCompleted)
         {
            return;
         }
         _loc2_ = TLobbyShortcutConstantlyModes.CAPACITY_Shortcuts;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.GetShortcutModeByIndex(_loc3_);
            _loc5_ = this.FUIConstantlys[_loc3_];
            switch(_loc4_)
            {
               case TLobbyShortcutMode.SHORTCUTMODE_Show:
                  _loc6_ = true;
                  break;
               case TLobbyShortcutMode.SHORTCUTMODE_Hidden:
                  _loc6_ = false;
            }
            this.FVisibleContorlGlobal[_loc3_] = _loc6_;
            if(this.FVisibleContorlGlobal[_loc3_] && this.FVisibleContorlLocation[_loc3_])
            {
               _loc5_.visible = true;
            }
            else
            {
               _loc5_.visible = false;
            }
            _loc3_++;
         }
         this.RePosition();
      }
   }
}

