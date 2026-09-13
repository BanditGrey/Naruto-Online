package Processors.Game.Lobby.Exercise.GuaGuaLe
{
   import Components.Standard.TUITab;
   import Foundation.Network.TPacket;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.GuaGuaLe.TGuaGuaLe;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerBaseInventories;
   import Logics.Streamization.Exercise.TUnstreamizerGuaGuaLe;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorGuaGuaLe extends TProcessorBaseActivity
   {
      
      protected static const STEP_NONE:int = 0;
      
      protected static const STEP_SHUFFLE:int = 1;
      
      protected static const STEP_OPEN_CARD:int = 2;
      
      protected static const BOX_COUNT:int = 9;
      
      protected static const TAB_COUNT:int = 3;
      
      protected static const TYPE_SGUA:uint = 0;
      
      protected static const TYPE_MGUA:uint = 1;
      
      protected static const TYPE_LGUA:uint = 2;
      
      protected static const REQ_GET_FREE_POINT:int = 1;
      
      protected static const REQ_GET_RECHARGE_POINT:int = 2;
      
      protected static const REQ_BUY_GUA_GUA_LE:int = 3;
      
      protected static const REQ_BUY_TEN_GUA_GUA_LE:int = 4;
      
      protected var FGuaGuaLe:TGuaGuaLe;
      
      protected var FUnstreamizerGuaGuaLe:TUnstreamizerGuaGuaLe;
      
      protected var FUnstreamizerBaseInventories:TUnstreamizerBaseInventories;
      
      protected var FIsPlaying:Boolean;
      
      protected var FUIBaseBox:TUIBaseBox;
      
      protected var FUITab:TUITab;
      
      protected var FTabVect:Vector.<MovieClip>;
      
      protected var FChangeTabIndex:int;
      
      protected var FCurType:int;
      
      protected var FTotalFrame:int;
      
      protected var FBackCardVect:Vector.<MovieClip>;
      
      protected var FBeClicked:Boolean;
      
      protected var FFlowStr:String;
      
      protected var FRewardIdx:int;
      
      protected var FChooseIdx:int;
      
      public function TProcessorGuaGuaLe(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FGuaGuaLe = SLogicsCore.GuaGuaLe;
         this.FUnstreamizerGuaGuaLe = new TUnstreamizerGuaGuaLe();
         this.FUnstreamizerBaseInventories = new TUnstreamizerBaseInventories();
         this.FUITab = new TUITab(this);
         this.FTabVect = new Vector.<MovieClip>(TAB_COUNT);
         this.FChangeTabIndex = 0;
         this.FBackCardVect = new Vector.<MovieClip>(BOX_COUNT);
         this.FFlowStr = "";
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         this.FUIBaseBox = new TUIBaseBox(this,BOX_COUNT);
         this.FUIBaseBox.Perform_UIDispatch(FMC_Scene["MC_Item"]);
         this.FUIBaseBox.OnOverlay = UIComponentsHintOnOver;
         this.FUIBaseBox.OnOut = UIComponentsHintOnOut;
         this.FTabVect[0] = FMC_Scene.btn_sgua;
         this.FTabVect[1] = FMC_Scene.btn_mgua;
         this.FTabVect[2] = FMC_Scene.btn_lgua;
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
         {
            this.FUITab.SetTabByIndex(this.FTabVect[_loc1_],_loc1_);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            this.FBackCardVect[_loc1_] = FMC_Scene["MC_Card" + _loc1_];
            this.FBackCardVect[_loc1_].visible = false;
            this.FBackCardVect[_loc1_].buttonMode = true;
            this.FBackCardVect[_loc1_].addEventListener(MouseEvent.CLICK,this.ProcessorOnChooseCard);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.ChangeTabOnSwitch;
         this.FUITab.Init();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.ResourcesPerform_UILocations();
         TGameUtil.setButtonMode(FMC_Scene.btn_recharge,true);
         FMC_Scene.btn_recharge.addEventListener(MouseEvent.CLICK,ProcessorOnRechargeUp);
         TGameUtil.setButtonMode(FMC_Scene.MC_Award.btn_get,true);
         FMC_Scene.MC_Award.btn_get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetPoint);
         TGameUtil.setButtonMode(FMC_Scene.BTN_GetFreePoint,true);
         FMC_Scene.BTN_GetFreePoint.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetFreePoint);
         TGameUtil.setButtonMode(FMC_Scene.btn_gua,true);
         FMC_Scene.btn_gua.addEventListener(MouseEvent.CLICK,this.ProcessorOnBeginMovie);
         TGameUtil.setButtonMode(FMC_Scene.btn_Tengua,true);
         FMC_Scene.btn_Tengua.addEventListener(MouseEvent.CLICK,this.ProcessorOnTenGuaUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         super.LogicsPerform();
         if(FInitialized)
         {
            if(this.FUIBaseBox)
            {
               this.FUIBaseBox.LogicsPerform();
            }
            if(this.FIsPlaying)
            {
               switch(this.FCurType)
               {
                  case STEP_SHUFFLE:
                     _loc2_ = FMC_Scene.MC_Shuffle;
                     break;
                  case STEP_OPEN_CARD:
                     _loc2_ = this.FBackCardVect[this.FChooseIdx].MC_Donghua;
               }
               _loc1_ = _loc2_.currentFrame;
               if(_loc1_ == this.FTotalFrame)
               {
                  this.FIsPlaying = false;
                  this.MovieEnd();
               }
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateBox();
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         FTF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FGuaGuaLe.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FGuaGuaLe.EndTime - 1) * 1000)));
         FTF_Desc.text = this.FGuaGuaLe.ActivityDesc;
         FMC_Scene.TF_Cost.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_COST_GUAGUALE_POINT,this.FGuaGuaLe.BoxVect[this.FChangeTabIndex].Price);
         FMC_Scene.TF_TenCost.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_COST_GUAGUALE_POINT,this.FGuaGuaLe.BoxVect[this.FChangeTabIndex].Discount);
         FMC_Scene.TF_Point.text = this.FGuaGuaLe.Point;
         if(this.FGuaGuaLe.Point >= this.FGuaGuaLe.BoxVect[this.FChangeTabIndex].Price)
         {
            TGameUtil.setButtonMode(FMC_Scene.btn_gua,true);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.btn_gua,false);
         }
         if(this.FGuaGuaLe.Point >= this.FGuaGuaLe.BoxVect[this.FChangeTabIndex].Discount)
         {
            TGameUtil.setButtonMode(FMC_Scene.btn_Tengua,true);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.btn_Tengua,false);
         }
         if(this.FGuaGuaLe.FreePointStatus == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Got.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.BTN_GetFreePoint,false);
         }
         else
         {
            FMC_Scene.MC_Got.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_GetFreePoint,true);
         }
         _loc1_ = this.FGuaGuaLe.PointStatus.length - 1;
         if(this.FGuaGuaLe.PointStatus[_loc1_] == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Point.TF_CurDesc.text = STRING_BASEACTIVITY.FORMAT_CUR_RECHARGE;
            FMC_Scene.MC_Point.TF_CurPoint.text = this.FGuaGuaLe.CurGold.toString();
            FMC_Scene.MC_Point.TF_Recharge.text = STRING_BASEACTIVITY.FORMAT_GET_ALL_AWARD;
            FMC_Scene.MC_Point.TF_Award.visible = false;
            FMC_Scene.MC_Award.MC_Got.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.MC_Award.btn_get,false);
         }
         else
         {
            FMC_Scene.MC_Point.TF_CurDesc.text = STRING_BASEACTIVITY.FORMAT_CUR_RECHARGE;
            FMC_Scene.MC_Point.TF_Recharge.visible = true;
            FMC_Scene.MC_Point.TF_Award.visible = true;
            FMC_Scene.MC_Award.MC_Got.visible = false;
            _loc2_ = this.FGuaGuaLe.GetCurIndex();
            FMC_Scene.MC_Point.TF_CurPoint.text = this.FGuaGuaLe.CurGold.toString();
            FMC_Scene.MC_Point.TF_Recharge.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_TOTAL_RECHARGE_GOLD,this.FGuaGuaLe.CreditRegion[_loc2_]);
            FMC_Scene.MC_Point.TF_Award.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_BONUS,this.FGuaGuaLe.PointRegion[_loc2_]);
            if(this.FGuaGuaLe.PointStatus[_loc2_] == TBaseActivity.STATUS_CANGET)
            {
               TGameUtil.setButtonMode(FMC_Scene.MC_Award.btn_get,true);
            }
            else
            {
               TGameUtil.setButtonMode(FMC_Scene.MC_Award.btn_get,false);
            }
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         var _loc4_:Vector.<int> = null;
         var _loc5_:int = 0;
         var _loc6_:TInventories = null;
         var _loc7_:TInventory = null;
         FMC_Scene.MC_Mask.visible = false;
         FMC_Scene.MC_Shuffle.visible = false;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            this.FBackCardVect[_loc1_].visible = false;
            _loc1_++;
         }
         _loc6_ = this.FGuaGuaLe.BoxVect[this.FChangeTabIndex].Inventories;
         this.FUIBaseBox.UpdateUI(_loc6_);
         this.FUIBaseBox.SetVisible(true);
      }
      
      protected function ChangeTabOnSwitch(param1:Object) : void
      {
         var _loc2_:int = param1 as int;
         if(_loc2_ == this.FChangeTabIndex)
         {
            return;
         }
         this.FChangeTabIndex = _loc2_;
         this.UpdateUI();
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      private function ProcessorOnGetFreePoint(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FBeClicked || this.FIsPlaying)
         {
            _loc2_ = STRING_BASEACTIVITY.FORMAT_WAIT_AMOUNT;
            ProcessorEffectText(_loc2_);
            return;
         }
         this.FBeClicked = true;
         PerformPacket_CS_AllReq(REQ_GET_FREE_POINT);
      }
      
      private function ProcessorOnGetPoint(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FBeClicked || this.FIsPlaying)
         {
            _loc2_ = STRING_BASEACTIVITY.FORMAT_WAIT_AMOUNT;
            ProcessorEffectText(_loc2_);
            return;
         }
         this.FBeClicked = true;
         PerformPacket_CS_AllReq(REQ_GET_RECHARGE_POINT);
      }
      
      private function ProcessorOnBeginMovie(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!param1.currentTarget.buttonMode)
         {
            _loc2_ = STRING_BASEACTIVITY.FORMAT_POINT_NOT_ENOUGH;
            ProcessorEffectText(_loc2_);
            return;
         }
         if(this.FBeClicked || this.FIsPlaying)
         {
            _loc2_ = STRING_BASEACTIVITY.FORMAT_WAIT_AMOUNT;
            ProcessorEffectText(_loc2_);
            return;
         }
         this.PlayMovie(STEP_SHUFFLE);
      }
      
      private function ProcessorOnChooseCard(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:Vector.<int> = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FBeClicked || this.FIsPlaying)
         {
            _loc2_ = STRING_BASEACTIVITY.FORMAT_WAIT_AMOUNT;
            ProcessorEffectText(_loc2_);
            return;
         }
         this.FBeClicked = true;
         this.FChooseIdx = int(String(param1.currentTarget.name).slice(7));
         _loc3_ = new Vector.<int>();
         _loc3_.push(this.FChangeTabIndex + 1);
         PerformPacket_CS_AllReq(REQ_BUY_GUA_GUA_LE,_loc3_);
      }
      
      protected function ProcessorOnTenGuaUp(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:Vector.<int> = null;
         if(!param1.currentTarget.buttonMode)
         {
            _loc2_ = STRING_BASEACTIVITY.FORMAT_POINT_NOT_ENOUGH;
            ProcessorEffectText(_loc2_);
            return;
         }
         this.FBeClicked = true;
         _loc3_ = new Vector.<int>();
         _loc3_.push(this.FChangeTabIndex + 1);
         PerformPacket_CS_AllReq(REQ_BUY_TEN_GUA_GUA_LE,_loc3_);
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(1,null);
      }
      
      public function PlayMovie(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TInventories = null;
         this.FCurType = param1;
         switch(param1)
         {
            case STEP_SHUFFLE:
               FMC_Scene.MC_Mask.visible = true;
               this.FUIBaseBox.SetVisible(false);
               _loc2_ = 0;
               while(_loc2_ < BOX_COUNT)
               {
                  this.FBackCardVect[_loc2_].visible = false;
                  _loc2_++;
               }
               _loc4_ = FMC_Scene.MC_Shuffle;
               break;
            case STEP_OPEN_CARD:
               _loc4_ = this.FBackCardVect[this.FChooseIdx];
               _loc5_ = this.FGuaGuaLe.GetShowInventories(FIndex,this.FRewardIdx,this.FChooseIdx);
               this.FUIBaseBox.UpdateUI(_loc5_);
               this.FUIBaseBox.SetVisible(true);
               FMC_Scene.MC_Mask.visible = false;
         }
         if(_loc4_)
         {
            _loc4_.visible = true;
            this.FIsPlaying = true;
            this.FTotalFrame = _loc4_.totalFrames;
            if(_loc4_.MC_Donghua)
            {
               _loc4_.MC_Donghua.gotoAndPlay(1);
            }
            else
            {
               _loc4_.gotoAndPlay(1);
            }
         }
      }
      
      public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         switch(this.FCurType)
         {
            case STEP_SHUFFLE:
               FMC_Scene.MC_Shuffle.visible = false;
               _loc1_ = 0;
               while(_loc1_ < BOX_COUNT)
               {
                  this.FBackCardVect[_loc1_].visible = true;
                  this.FBackCardVect[_loc1_].MC_Donghua.gotoAndStop(1);
                  _loc1_++;
               }
               break;
            case STEP_OPEN_CARD:
               FMC_Scene.MC_Shuffle.visible = false;
               _loc1_ = 0;
               while(_loc1_ < BOX_COUNT)
               {
                  this.FBackCardVect[_loc1_].visible = false;
                  _loc1_++;
               }
               ProcessorEffectText(this.FFlowStr);
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.visible = true;
         this.alpha = 1;
         if(FMC_EffectLeft)
         {
            FMC_EffectLeft.play();
         }
         if(FMC_EffectRight)
         {
            FMC_EffectRight.play();
         }
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.FIsPlaying = false;
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         super.ProcessorOnLoadInfoRet();
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerGuaGuaLe.Unstreamize(_loc2_,this.FGuaGuaLe,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorAllRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventories = null;
         var _loc9_:TInventory = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         _loc10_ = _loc2_.readShort();
         switch(_loc7_)
         {
            case REQ_GET_FREE_POINT:
               this.FGuaGuaLe.FreePointStatus = TBaseActivity.STATUS_GETED;
               this.FGuaGuaLe.Point += this.FGuaGuaLe.FreePoint;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET;
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FGuaGuaLe.CheckEffect());
               this.UpdateText();
               break;
            case REQ_GET_RECHARGE_POINT:
               _loc5_ = this.FGuaGuaLe.GetCurIndex();
               if(_loc5_ < this.FGuaGuaLe.PointRegion.length)
               {
                  this.FGuaGuaLe.Point += this.FGuaGuaLe.PointRegion[_loc5_];
                  this.FGuaGuaLe.PointStatus[_loc5_] = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET;
                  this.FGuaGuaLe.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  ProcessorCheckEffect(FActivityID,this.FGuaGuaLe.CheckEffect());
                  this.UpdateText();
               }
               break;
            case REQ_BUY_GUA_GUA_LE:
               FIndex = _loc2_.readUnsignedInt() - 1;
               this.FRewardIdx = _loc2_.readUnsignedInt() - 1;
               _loc9_ = this.FGuaGuaLe.BoxVect[FIndex].Inventories.GetInventoryByIndex(this.FRewardIdx);
               this.FFlowStr = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               this.FFlowStr += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
               this.PlayMovie(STEP_OPEN_CARD);
               this.FGuaGuaLe.Point -= this.FGuaGuaLe.BoxVect[FIndex].Price;
               this.UpdateText();
               break;
            case REQ_BUY_TEN_GUA_GUA_LE:
               FIndex = _loc2_.readUnsignedInt() - 1;
               this.FFlowStr = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < 10)
               {
                  _loc11_ = _loc2_.readUnsignedInt() - 1;
                  _loc9_ = this.FGuaGuaLe.BoxVect[FIndex].Inventories.GetInventoryByIndex(_loc11_);
                  this.FFlowStr += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               this.FGuaGuaLe.Point -= this.FGuaGuaLe.BoxVect[FIndex].Discount;
               this.UpdateText();
               ProcessorEffectText(this.FFlowStr);
         }
      }
      
      override public function ProcessorActivityThirdLoadLogRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            ProcessorClose();
            return;
         }
         _loc2_.readUnsignedInt();
         ProcessorUnstreamActivityLog(this.FGuaGuaLe,_loc2_);
      }
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _loc2_ = param1.Data;
         if(this.FGuaGuaLe.CreditRegion.length > 0)
         {
            _loc2_.readUnsignedShort();
            this.FGuaGuaLe.CurGold = _loc2_.readUnsignedInt();
            this.FGuaGuaLe.Point = _loc2_.readUnsignedInt();
            this.FGuaGuaLe.ChangeStatus();
            ProcessorCheckEffect(FActivityID,this.FGuaGuaLe.CheckEffect());
            if(FMC_Scene)
            {
               this.UpdateText();
            }
         }
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([1,10,100,1000,10000]);
         var _loc5_:Vector.<int> = Vector.<int>([1,10,100,1000,10000]);
         var _loc6_:Vector.<int> = Vector.<int>([-1,-1,1,1,1]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         TUtilityString.FlushUTF(_loc3_,"万圣节活动");
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeUnsignedInt(1000);
         _loc3_.writeUnsignedInt(1000);
         _loc3_.writeUnsignedInt(1000);
         _loc3_.writeShort(_loc4_.length);
         _loc1_ = 0;
         while(_loc1_ < _loc4_.length)
         {
            _loc3_.writeUnsignedInt(_loc4_[_loc1_]);
            _loc3_.writeUnsignedInt(_loc5_[_loc1_]);
            _loc3_.writeInt(_loc6_[_loc1_]);
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeUnsignedInt(10 * _loc1_ + 1);
            _loc3_.writeShort(9);
            _loc2_ = 0;
            while(_loc2_ < 9)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc2_ + _loc1_);
               _loc3_.writeUnsignedInt(1 + _loc2_ + _loc1_);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
      
      public function TestInit1() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeUnsignedInt(20);
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

