package Processors.Game.Lobby.Exercise.SuperChristmas
{
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.Json.TActivityTaskReward;
   import Logics.DatebaseVO.VO.Json.TTaskReward;
   import Logics.DatebaseVO.VO.TActivityTask;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.SuperChristmas.TSuperChristmas;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerSuperChristmas;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TProcessorSuperChristmas extends TProcessorBaseActivity
   {
      
      protected static const SHOW_ITEM_COUNT:int = 3;
      
      public static const REQ_TYPE_GET_GIFT:int = 1;
      
      public static const REQ_TYPE_GET_SUPER_BOX:int = 2;
      
      public static const REQ_TYPE_FINISH_TASK:int = 3;
      
      public static const REQ_TYPE_CANCEL_TASK:int = 4;
      
      public static const MOVIE_TYPE_GET_SUPER_BOX:int = 1;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FSuperChristmas:TSuperChristmas;
      
      protected var FUnstreamizerSuperChristmas:TUnstreamizerSuperChristmas;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FTF_OpenTime:TextField;
      
      protected var FNextTimeID:int;
      
      protected var FMovieType:int;
      
      public function TProcessorSuperChristmas(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FSuperChristmas = SLogicsCore.SuperChristmas;
         this.FUnstreamizerSuperChristmas = new TUnstreamizerSuperChristmas();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FBuyBoxDate = new Object();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         this.FTF_OpenTime = FMC_Scene.MC_Begin.MC_Waiting.MC_Time.TF_Time;
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_Begin.MC_Task.MC_Rewards);
         this.FShowItem.OnOverlay = UIComponentsHintOnOver;
         this.FShowItem.OnOut = UIComponentsHintOnOut;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         FMC_Scene.MC_Begin.MC_Waiting.MC_Box.buttonMode = true;
         FMC_Scene.MC_Begin.MC_Waiting.MC_Box.addEventListener(MouseEvent.CLICK,this.ProcessorOnSuperBoxUp);
         FMC_Scene.MC_Begin.MC_Waiting.MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSuperBoxOver);
         FMC_Scene.MC_Begin.MC_Waiting.MC_Box.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         FMC_Scene.MC_Begin.MC_Gift.buttonMode = true;
         FMC_Scene.MC_Begin.MC_Gift.MC_Click.visible = false;
         FMC_Scene.MC_Begin.MC_Gift.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
         FMC_Scene.MC_Begin.MC_Gift.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
         FMC_Scene.MC_Begin.MC_Gift.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         TGameUtil.setButtonMode(FMC_Scene.MC_Begin.MC_Task.BTN_Finish,true);
         FMC_Scene.MC_Begin.MC_Task.BTN_Finish.addEventListener(MouseEvent.CLICK,this.ProcessorOnFinishUp);
         TGameUtil.setButtonMode(FMC_Scene.MC_Begin.MC_Task.BTN_Cancel,true);
         FMC_Scene.MC_Begin.MC_Task.BTN_Cancel.addEventListener(MouseEvent.CLICK,this.ProcessorOnCancelUp);
         TGameUtil.setButtonMode(FMC_Scene.MC_Begin.MC_Task.BTN_Go,true);
         FMC_Scene.MC_Begin.MC_Task.BTN_Go.addEventListener(MouseEvent.CLICK,this.ProcessorOnGoUp);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && Boolean(FMC_Scene.visible) && this.FIsOpen)
         {
            if(Boolean(this.FSuperChristmas) && Boolean(this.FTF_OpenTime))
            {
               this.FTF_OpenTime.text = TGameUtil.fomatTime(this.FSuperChristmas.NextTime - STimingCore.GetServerTick());
            }
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:int = 0;
         _loc1_ = this.FSuperChristmas.GameStatus;
         if(_loc1_ == TBaseActivity.STATUS_CANNOTGET)
         {
            FMC_Scene.MC_NotBegin.visible = true;
            FMC_Scene.MC_Begin.visible = false;
            FMC_Scene.MC_End.visible = false;
         }
         else if(_loc1_ == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.MC_NotBegin.visible = false;
            FMC_Scene.MC_Begin.visible = true;
            FMC_Scene.MC_End.visible = false;
            this.UpdateBox();
            this.UpdateGift();
         }
         else
         {
            FMC_Scene.MC_NotBegin.visible = false;
            FMC_Scene.MC_Begin.visible = false;
            FMC_Scene.MC_End.visible = true;
         }
         this.SetNextTimeInterval();
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TDessertHouseTask = null;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         if(this.FSuperChristmas.NextTime > STimingCore.GetServerTick())
         {
            FMC_Scene.MC_Begin.MC_Task.visible = false;
            FMC_Scene.MC_Begin.MC_Waiting.visible = true;
            _loc3_ = FMC_Scene.MC_Begin.MC_Waiting.MC_Box;
            _loc3_.MC_Icon.gotoAndStop(1);
            _loc3_.MC_Icon.visible = true;
            _loc3_.MC_Click.visible = false;
            _loc3_.MC_Get.visible = false;
            FMC_Scene.MC_Begin.MC_Waiting.MC_Talk.TF_Talk.text = this.FSuperChristmas.DescListNew[0];
         }
         else if(Boolean(this.FSuperChristmas.ActivityTask) && this.FSuperChristmas.ActivityTask.Identify != 0)
         {
            FMC_Scene.MC_Begin.MC_Waiting.visible = false;
            FMC_Scene.MC_Begin.MC_Task.visible = true;
            _loc4_ = FMC_Scene.MC_Begin.MC_Task;
            _loc2_ = this.FSuperChristmas.ActivityTask;
            _loc1_ = _loc2_.Step;
            _loc4_.TF_Desc.text = TUtilityString.Format(_loc2_.TaskDesc,_loc2_.TaskReq[_loc1_]);
            _loc4_.TF_Process.text = _loc2_.Process + "/" + _loc2_.ClientTaskReq[_loc1_];
            this.FShowItem.UpdateUI(_loc2_.TaskAward[_loc1_]);
            if(_loc2_.Process >= _loc2_.ClientTaskReq[_loc1_])
            {
               _loc4_.BTN_Finish.visible = true;
               _loc4_.BTN_Cancel.visible = false;
            }
            else
            {
               _loc4_.BTN_Finish.visible = false;
               _loc4_.BTN_Cancel.visible = true;
            }
         }
         else
         {
            FMC_Scene.MC_Begin.MC_Waiting.visible = true;
            FMC_Scene.MC_Begin.MC_Task.visible = false;
            _loc3_ = FMC_Scene.MC_Begin.MC_Waiting.MC_Box;
            _loc3_.MC_Icon.gotoAndPlay(1);
            _loc3_.MC_Icon.visible = true;
            _loc3_.MC_Click.visible = true;
            _loc3_.MC_Get.visible = false;
            FMC_Scene.MC_Begin.MC_Waiting.MC_Talk.TF_Talk.text = this.FSuperChristmas.DescListNew[0];
         }
      }
      
      protected function UpdateGift() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = this.FSuperChristmas.Gift.Status;
         _loc2_ = FMC_Scene.MC_Begin.MC_Gift;
         FMC_Scene.MC_Begin.TF_Text.text = this.FSuperChristmas.DescListNew[1];
         if(_loc1_ == TBaseActivity.STATUS_CANNOTGET)
         {
            _loc2_.MC_Click.visible = false;
            _loc2_.MC_Got.visible = false;
         }
         else if(_loc1_ == TBaseActivity.STATUS_CANGET)
         {
            _loc2_.MC_Click.visible = true;
            _loc2_.MC_Got.visible = false;
         }
         else
         {
            _loc2_.MC_Click.visible = false;
            _loc2_.MC_Got.visible = true;
         }
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function SetNextTimeInterval() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(this.FNextTimeID != 0)
         {
            clearTimeout(this.FNextTimeID);
            this.FNextTimeID = 0;
         }
         _loc2_ = (this.FSuperChristmas.NextTime - STimingCore.GetServerTick()) * 1000 + 500;
         if(_loc2_ <= 0)
         {
         }
         if(_loc2_ > 0 && _loc2_ < int.MAX_VALUE)
         {
            this.FNextTimeID = setTimeout(this.PerformPacket_CS_LoadInfoReq,_loc2_);
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         var _loc4_:Vector.<int> = null;
         if(this.FBeClicked)
         {
            return;
         }
         this.FBeClicked = true;
         _loc4_ = new Vector.<int>();
         PerformPacket_CS_AllReq(param1,_loc4_);
      }
      
      protected function ProcessorOnSuperBoxUp(param1:MouseEvent) : void
      {
         if(Boolean(this.FSuperChristmas) && this.FSuperChristmas.NextTime <= STimingCore.GetServerTick())
         {
            this.ProcessorOnGetBoxUp(REQ_TYPE_GET_SUPER_BOX);
         }
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         if(Boolean(this.FSuperChristmas) && Boolean(this.FSuperChristmas.Gift) && this.FSuperChristmas.Gift.Status == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorOnGetBoxUp(REQ_TYPE_GET_GIFT);
         }
      }
      
      protected function ProcessorOnFinishUp(param1:MouseEvent) : void
      {
         if(Boolean(this.FSuperChristmas) && Boolean(this.FSuperChristmas.ActivityTask))
         {
            this.ProcessorOnGetBoxUp(REQ_TYPE_FINISH_TASK);
         }
      }
      
      protected function ProcessorOnCancelUp(param1:MouseEvent) : void
      {
         if(Boolean(this.FSuperChristmas) && Boolean(this.FSuperChristmas.ActivityTask))
         {
            this.ProcessorOnGetBoxUp(REQ_TYPE_CANCEL_TASK);
         }
      }
      
      protected function ProcessorOnGoUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         if(Boolean(this.FSuperChristmas) && Boolean(this.FSuperChristmas.ActivityTask))
         {
            ProcessorOnGoto(this.FSuperChristmas.ActivityTask.Go);
            this.ProcessorOnCloseWindow();
         }
      }
      
      protected function ProcessorOnSuperBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(this.FSuperChristmas)
         {
            _loc2_ = this.FSuperChristmas.DescListNew[2].split("%n").join("\n");
            ProcessorOnShowHtmlText(_loc2_);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         if(Boolean(this.FSuperChristmas) && Boolean(this.FSuperChristmas.Gift))
         {
            ProcessorOnNewBoxOver(this.FSuperChristmas.Gift.Inventories);
         }
      }
      
      protected function ProcessorOnCloseWindow() : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
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
         this.FIsOpen = true;
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
         this.visible = false;
         this.FIsOpen = false;
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerSuperChristmas.Unstreamize(_loc2_,this.FSuperChristmas,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
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
         _loc4_ = int(_loc2_.readUnsignedInt());
         ProcessorUnstreamActivityLog(this.FSuperChristmas,_loc2_);
      }
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
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
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:TBaseBox = null;
         var _loc14_:uint = 0;
         var _loc15_:TBins = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:TDessertHouseTask = null;
         var _loc20_:TActivityTaskReward = null;
         var _loc21_:TDessertHouseTask = null;
         var _loc22_:TTaskReward = null;
         var _loc23_:TActivityTask = null;
         var _loc24_:Vector.<uint> = null;
         var _loc25_:Vector.<uint> = null;
         var _loc26_:uint = 0;
         var _loc27_:TBins = null;
         _loc24_ = new Vector.<uint>();
         _loc25_ = new Vector.<uint>();
         _loc15_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         switch(_loc7_)
         {
            case REQ_TYPE_GET_SUPER_BOX:
               this.FSuperChristmas.NextTime = _loc2_.readUnsignedInt();
               _loc18_ = int(_loc2_.readUnsignedInt());
               if(_loc18_ == 0)
               {
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc16_ = int(_loc2_.readUnsignedInt());
                  _loc5_ = 0;
                  while(_loc5_ < _loc16_)
                  {
                     _loc14_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc12_ = _loc2_.readUnsignedInt();
                     _loc4_ += STRING_COMMON.GetItemNameByType(_loc14_,_loc11_) + "*" + _loc12_ + "\n";
                     _loc5_++;
                  }
                  this.FSuperChristmas.ActivityTask = null;
                  ProcessorEffectText(_loc4_);
                  this.PlayMovie(MOVIE_TYPE_GET_SUPER_BOX);
               }
               else
               {
                  _loc27_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ActivityTaskConfig);
                  _loc23_ = _loc27_.GetDatebaseByValue2("Identifier",_loc18_,"Tasktype",ActivityID) as TActivityTask;
                  _loc19_ = new TDessertHouseTask(_loc18_);
                  _loc19_.Step = 0;
                  _loc19_.Process = 0;
                  _loc19_.Status = 1;
                  _loc19_.TaskName = _loc23_.TaskName;
                  _loc19_.TaskDesc = _loc23_.TaskDesc;
                  _loc19_.TaskReq = _loc23_.Requirements;
                  _loc19_.ClientTaskReq = _loc23_.ClientReq;
                  _loc19_.TaskPoint = _loc23_.Points;
                  _loc19_.MaxReset = _loc23_.Reset;
                  _loc19_.Consume = _loc23_.Consume;
                  _loc19_.Go = _loc23_.Go;
                  _loc16_ = int(_loc23_.Rewards.length);
                  _loc5_ = 0;
                  while(_loc5_ < _loc16_)
                  {
                     _loc24_.length = 0;
                     _loc25_.length = 0;
                     _loc8_ = new TInventories();
                     _loc20_ = _loc23_.Rewards[_loc5_];
                     _loc17_ = int(_loc20_.Rewards.length);
                     _loc6_ = 0;
                     while(_loc6_ < _loc17_)
                     {
                        _loc22_ = _loc20_.Rewards[_loc6_];
                        _loc10_ = _loc22_.Type;
                        _loc11_ = _loc22_.Code;
                        _loc26_ = CONST_COMMON.GetItemIDByType(_loc10_,_loc11_,_loc15_);
                        _loc24_.push(_loc26_);
                        _loc25_.push(_loc22_.Amount);
                        _loc6_++;
                     }
                     this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc8_,_loc24_);
                     _loc6_ = 0;
                     while(_loc6_ < _loc17_)
                     {
                        _loc9_ = _loc8_.GetInventoryByIndex(_loc6_);
                        _loc9_.Quantity = _loc25_[_loc6_];
                        _loc6_++;
                     }
                     _loc19_.TaskAward.push(_loc8_);
                     _loc5_++;
                  }
                  this.FSuperChristmas.ActivityTask = _loc19_;
                  _loc4_ = this.FSuperChristmas.DescListNew[3];
                  ProcessorEffectText(_loc4_);
                  this.UpdateUI();
               }
               break;
            case REQ_TYPE_FINISH_TASK:
               this.FSuperChristmas.NextTime = _loc2_.readUnsignedInt();
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc21_ = this.FSuperChristmas.ActivityTask;
               _loc5_ = 0;
               while(_loc5_ < _loc21_.TaskAward[_loc21_.Step].Count)
               {
                  _loc9_ = _loc21_.TaskAward[_loc21_.Step].GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               this.UpdateUI();
               break;
            case REQ_TYPE_CANCEL_TASK:
               this.FSuperChristmas.NextTime = _loc2_.readUnsignedInt();
               this.FSuperChristmas.ActivityTask = null;
               this.UpdateUI();
               break;
            case REQ_TYPE_GET_GIFT:
               this.FSuperChristmas.Gift.Status = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < this.FSuperChristmas.Gift.Inventories.Count)
               {
                  _loc9_ = this.FSuperChristmas.Gift.Inventories.GetInventoryByIndex(_loc5_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               ProcessorEffectText(_loc4_);
               this.UpdateUI();
         }
      }
      
      public function PlayMovie(param1:int) : void
      {
         var _loc2_:MovieClip = null;
         if(param1 == MOVIE_TYPE_GET_SUPER_BOX)
         {
            _loc2_ = FMC_Scene.MC_Begin.MC_Waiting.MC_Box;
            _loc2_.MC_Click.visible = false;
            _loc2_.MC_Icon.visible = false;
            _loc2_.MC_Get.visible = true;
            _loc2_.MC_Get.gotoAndPlay(1);
            setTimeout(this.UpdateUI,2000);
         }
      }
      
      public function Test() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(4);
         TUtilityString.FlushUTF(_loc3_,"NPC对白1");
         TUtilityString.FlushUTF(_loc3_,"XXXX可以领取");
         TUtilityString.FlushUTF(_loc3_,"惊喜礼包TIPS");
         TUtilityString.FlushUTF(_loc3_,"你得到1个圣诞任务");
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(STimingCore.GetServerTime() + 10);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100002 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

