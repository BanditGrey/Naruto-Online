package Processors.Game.Lobby.Exercise.GoldTree
{
   import Components.Standard.TUITab;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.GoldTree.TGoldTree;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerGoldTree;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorWindowEquipDesc;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorGoldTree extends TProcessorBaseActivity
   {
      
      protected static const TREE_MAX_LEVEL:int = 4;
      
      protected static const RETURN_BOX_COUNT:int = 5;
      
      public static const ACTIVITY_2_WATER:int = 1;
      
      public static const ACTIVITY_2_GET:int = 2;
      
      public static const TAB_COUNT:int = 2;
      
      public static const TAB_PLANT:int = 0;
      
      public static const TAB_RETURN:int = 1;
      
      protected static const SHOW_ITEM_COUNT:int = 4;
      
      public static const MOVIE_OF_PLAY_GAME:int = 0;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FGoldTree:TGoldTree;
      
      protected var FUnstreamizerGoldTree:TUnstreamizerGoldTree;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      protected var FMovieType:int;
      
      protected var FFrameCount:int;
      
      protected var FTotalFrame:int;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      protected var FChangeTabIndex:int;
      
      protected var FUITab:TUITab;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FProcessorWindowEquipDesc:TProcessorWindowEquipDesc;
      
      protected var FProcessorFebActiveWaterLog:TProcessorFebActiveWaterLog;
      
      public function TProcessorGoldTree(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FGoldTree = SLogicsCore.GoldTree;
         this.FUnstreamizerGoldTree = new TUnstreamizerGoldTree();
         this.FBuyBoxDate = new Object();
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowRecruit.y = (CONST_COMMON.STAGE_Height - 358) / 2;
         this.FProcessorWindowEquipDesc = new TProcessorWindowEquipDesc(this.Parent);
         this.FProcessorFebActiveWaterLog = new TProcessorFebActiveWaterLog(this.Parent);
         this.FProcessorFebActiveWaterLog.OnCloseUp = this.ProcessorOnHideWindow;
         this.FProcessorFebActiveWaterLog.Visible = false;
         this.FUITab = new TUITab(this);
         this.FChangeTabIndex = 0;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TUIBaseBox = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < TREE_MAX_LEVEL)
         {
            _loc4_ = FMC_Scene.MC_Plant["MC_Tree" + _loc1_];
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTreeOver);
            _loc4_.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < RETURN_BOX_COUNT)
         {
            _loc4_ = FMC_Scene.MC_Return["MC_Box" + _loc1_];
            TGameUtil.setButtonMode(_loc4_.BTN_Get,true);
            _loc4_.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnReturnUp);
            _loc1_++;
         }
         FMC_Scene.MC_Movie.visible = false;
         FMC_Scene.MC_Movie.mouseEnabled = false;
         this.FMC_Mask = FMC_Scene.MC_Bar.MC_Mask;
         this.FBarMaxWidth = this.FMC_Mask.width;
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_Plant.MC_ShowItems);
         this.FShowItem.OnOverlay = UIComponentsHintOnOver;
         this.FShowItem.OnOut = UIComponentsHintOnOut;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Water,true);
         FMC_Scene.BTN_Water.addEventListener(MouseEvent.CLICK,this.ProcessorOnWaterUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_AllLog,true);
         FMC_Scene.BTN_AllLog.addEventListener(MouseEvent.CLICK,this.ProcessorOnOpenAllLog);
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
         {
            this.FUITab.SetTabByIndex(FMC_Scene["MC_Tab" + _loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.ChangeTabOnSwitch;
         this.FUITab.Init();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && Boolean(FMC_Scene.visible) && Boolean(this.FGoldTree))
         {
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
            if(this.FIsPlaying)
            {
               switch(this.FMovieType)
               {
                  case MOVIE_OF_PLAY_GAME:
                     _loc2_ = int(FMC_Scene.MC_Movie.currentFrame);
               }
               if(_loc2_ == this.FTotalFrame)
               {
                  this.FIsPlaying = false;
                  this.FFrameCount = 0;
                  this.MovieEnd();
               }
               else
               {
                  ++this.FFrameCount;
                  if(this.FFrameCount > 100)
                  {
                     this.FIsPlaying = false;
                     this.FFrameCount = 0;
                     this.UpdateUI();
                  }
               }
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateTree();
         this.UpdateTreeList();
         this.UpdateReturn();
         this.UpdateText();
         if(this.FChangeTabIndex == TAB_PLANT)
         {
            FMC_Scene.MC_Plant.visible = true;
            FMC_Scene.MC_Return.visible = false;
         }
         else
         {
            FMC_Scene.MC_Plant.visible = false;
            FMC_Scene.MC_Return.visible = true;
         }
      }
      
      protected function UpdateTree() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         FMC_Scene.MC_Tree.gotoAndStop(this.FGoldTree.CurTreeLevel);
         _loc3_ = this.FGoldTree.TreeList[this.FGoldTree.CurTreeLevel - 1];
         if(this.FGoldTree.CurTreeLevel == 1)
         {
            FMC_Scene.MC_Buff.TF_Desc.text = this.FGoldTree.DescListNew[5];
            FMC_Scene.TF_Level.text = this.FGoldTree.DescListNew[11];
         }
         else
         {
            FMC_Scene.TF_Level.text = "LV" + (this.FGoldTree.CurTreeLevel - 1);
            if(this.FGoldTree.ReturnType == TBaseActivity.RETURN_GOLD)
            {
               FMC_Scene.MC_Buff.TF_Desc.text = TUtilityString.Format(this.FGoldTree.DescListNew[4],_loc3_.Count);
            }
            else
            {
               FMC_Scene.MC_Buff.TF_Desc.text = TUtilityString.Format(this.FGoldTree.DescListNew[19],_loc3_.Count);
            }
         }
         FMC_Scene.MC_Bar.TF_Count.text = this.FGoldTree.CurTreeValue + "/" + _loc3_.Max;
         _loc1_ = Number(this.FGoldTree.CurTreeValue / _loc3_.Max) * this.FBarMaxWidth;
         _loc2_ = Math.min(_loc1_,this.FBarMaxWidth);
         this.FMC_Mask.width = _loc2_;
         if(this.FGoldTree.GameStatus == TGoldTree.STATUS_OF_PLANT)
         {
            FMC_Scene.MC_End.visible = false;
            if(this.FGoldTree.CurTreeLevel == TREE_MAX_LEVEL)
            {
               FMC_Scene.MC_MaxLevel.visible = true;
               FMC_Scene.BTN_Water.visible = false;
               FMC_Scene.TF_WaterCount.text = "";
            }
            else
            {
               FMC_Scene.MC_MaxLevel.visible = false;
               FMC_Scene.BTN_Water.visible = true;
               FMC_Scene.TF_WaterCount.text = "*" + this.FGoldTree.WaterCount;
               if(this.FGoldTree.WaterCount > 0)
               {
                  TGameUtil.setButtonMode(FMC_Scene.BTN_Water,true);
               }
               else
               {
                  TGameUtil.setButtonMode(FMC_Scene.BTN_Water,false);
               }
            }
            FMC_Scene.MC_Tip.visible = true;
            FMC_Scene.MC_Tip.MC_Tip.TF_Text.text = this.FGoldTree.DescListNew[21];
         }
         else
         {
            if(this.FGoldTree.CurTreeLevel == TREE_MAX_LEVEL)
            {
               FMC_Scene.MC_End.visible = false;
               FMC_Scene.MC_MaxLevel.visible = true;
            }
            else
            {
               FMC_Scene.MC_End.visible = true;
               FMC_Scene.MC_MaxLevel.visible = false;
            }
            FMC_Scene.BTN_Water.visible = false;
            FMC_Scene.TF_WaterCount.text = "";
            FMC_Scene.MC_Tip.visible = false;
         }
      }
      
      protected function UpdateTreeList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TBaseBox = null;
         var _loc3_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < TREE_MAX_LEVEL)
         {
            _loc3_ = FMC_Scene.MC_Plant["MC_Tree" + _loc1_];
            _loc2_ = this.FGoldTree.TreeList[_loc1_];
            _loc3_.gotoAndStop(_loc1_ + 1);
            if(_loc1_ == this.FGoldTree.CurTreeLevel - 1)
            {
               _loc3_.MC_Select.visible = true;
            }
            else
            {
               _loc3_.MC_Select.visible = false;
            }
            _loc1_++;
         }
         FMC_Scene.MC_Plant.TF_GoldDesc.text = this.FGoldTree.DescListNew[2];
         _loc2_ = this.FGoldTree.TreeList[this.FGoldTree.CurTreeLevel - 1];
         if(this.FGoldTree.CurTreeLevel == 1)
         {
            FMC_Scene.MC_Plant.MC_TreeStatus.TF_Level.text = this.FGoldTree.DescListNew[11];
            FMC_Scene.MC_Plant.MC_TreeStatus.TF_Desc.text = this.FGoldTree.DescListNew[12];
         }
         else
         {
            FMC_Scene.MC_Plant.MC_TreeStatus.TF_Level.text = "LV" + (this.FGoldTree.CurTreeLevel - 1);
            if(this.FGoldTree.ReturnType == TBaseActivity.RETURN_GOLD)
            {
               FMC_Scene.MC_Plant.MC_TreeStatus.TF_Desc.text = TUtilityString.Format(this.FGoldTree.DescListNew[22],_loc2_.Count);
            }
            else
            {
               FMC_Scene.MC_Plant.MC_TreeStatus.TF_Desc.text = TUtilityString.Format(this.FGoldTree.DescListNew[23],_loc2_.Count);
            }
         }
         this.FShowItem.UpdateUI(this.FGoldTree.ShowItems);
      }
      
      protected function UpdateReturn() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TBaseBox = null;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         _loc2_ = this.FGoldTree.TreeList[this.FGoldTree.CurTreeLevel - 1];
         if(this.FGoldTree.CurTreeLevel == 1)
         {
            FMC_Scene.MC_Return.TF_TreeLevel.text = this.FGoldTree.DescListNew[11];
         }
         else
         {
            FMC_Scene.MC_Return.TF_TreeLevel.text = "LV" + (this.FGoldTree.CurTreeLevel - 1);
         }
         if(this.FGoldTree.ReturnType == TBaseActivity.RETURN_GOLD)
         {
            FMC_Scene.MC_Return.TF_GoldCount.text = _loc2_.Count + STRING_COMMON.ITEMNAME_Gold;
         }
         else
         {
            FMC_Scene.MC_Return.TF_GoldCount.text = _loc2_.Count + STRING_COMMON.ITEMNAME_Vouchers;
         }
         FMC_Scene.MC_Return.TF_ReturnTime.text = this.FGoldTree.DescListNew[3];
         _loc1_ = 0;
         while(_loc1_ < RETURN_BOX_COUNT)
         {
            _loc3_ = FMC_Scene.MC_Return["MC_Box" + _loc1_];
            _loc4_ = this.FGoldTree.ReturnList[_loc1_];
            _loc3_.TF_DayDesc.text = TUtilityString.Format(this.FGoldTree.DescListNew[10],TUtilityDate.FormatMMDDChineseNew(new Date(STimingCore.GetClientShowTime(_loc4_.Time) * 1000)));
            _loc3_.TF_Count.text = "*" + _loc4_.Count;
            if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc3_.BTN_Get.visible = true;
               _loc3_.MC_Status.visible = false;
            }
            else if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc3_.BTN_Get.visible = false;
               _loc3_.MC_Status.visible = true;
               _loc3_.MC_Status.gotoAndStop(4);
            }
            else if(_loc4_.Status == TBaseActivity.STATUS_GETED)
            {
               _loc3_.BTN_Get.visible = false;
               _loc3_.MC_Status.visible = true;
               _loc3_.MC_Status.gotoAndStop(1);
            }
            else if(_loc4_.Status == 2)
            {
               _loc3_.BTN_Get.visible = false;
               _loc3_.MC_Status.visible = true;
               _loc3_.MC_Status.gotoAndStop(2);
            }
            else
            {
               _loc3_.BTN_Get.visible = false;
               _loc3_.MC_Status.visible = true;
               _loc3_.MC_Status.gotoAndStop(3);
            }
            if(this.FGoldTree.ReturnType == TBaseActivity.RETURN_GOLD)
            {
               _loc3_.MC_Icon.gotoAndStop(1);
            }
            else
            {
               _loc3_.MC_Icon.gotoAndStop(2);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FGoldTree.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FGoldTree.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FGoldTree.DescListNew[1];
         FMC_Scene.TF_RechargeDesc.text = TUtilityString.Format(this.FGoldTree.DescListNew[6],this.FGoldTree.RechargeGold);
         FMC_Scene.TF_ConsumeDesc.text = TUtilityString.Format(this.FGoldTree.DescListNew[7],this.FGoldTree.ConsumeGold);
         FMC_Scene.TF_ConsumeTip.text = TUtilityString.Format(this.FGoldTree.DescListNew[8],this.FGoldTree.ConsumeAddTimes);
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
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:String = "", param6:int = 0, param7:int = 0) : void
      {
         this.FBuyBoxDate.ActivityType = param1;
         this.FBuyBoxDate.BoxIndex = param3;
         this.FBuyBoxDate.Cost = param2;
         this.FBuyBoxDate.CostType = param4;
         this.FBuyBoxDate.BoxIndex1 = param6;
         this.FBuyBoxDate.ConfirmType = param7;
         if(param4 != TBaseActivity.SWEET_TYPE_GOLD)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
            return;
         }
         if(!FUIWindowConfirmation.IsSelected)
         {
            this.FCost = param2;
            if(param5 != "")
            {
               FUIWindowConfirmation.Text = param5;
            }
            else
            {
               FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCost);
            }
            FUIWindowConfirmation.SetCheckBox(true);
            FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      override protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         var _loc2_:TCharacter = null;
         _loc2_ = SLogicsCore.Character;
         if(_loc2_.CreditGold >= this.FBuyBoxDate.Cost)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:int = 0;
         var _loc6_:Vector.<int> = null;
         if(this.FBeClicked)
         {
            return;
         }
         this.FBeClicked = true;
         _loc6_ = new Vector.<int>();
         if(param2 != 0)
         {
            _loc6_.push(param2);
         }
         if(param3 != 0)
         {
            _loc6_.push(param3);
         }
         PerformPacket_CS_AllReq(param1,_loc6_);
      }
      
      protected function ProcessorOnWaterUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(Boolean(!this.FIsPlaying) && Boolean(this.FGoldTree) && this.FGoldTree.WaterCount > 0)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_2_WATER);
         }
      }
      
      protected function ProcessorOnReturnUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!this.FIsPlaying && Boolean(this.FGoldTree))
         {
            _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
            this.ProcessorOnGetBoxUp(ACTIVITY_2_GET,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnOpenAllLog(param1:MouseEvent) : void
      {
         this.FProcessorFebActiveWaterLog.Visible = true;
         this.FProcessorFebActiveWaterLog.UpdateUI();
      }
      
      protected function ProcessorOnHideWindow(param1:MouseEvent) : void
      {
         this.FProcessorFebActiveWaterLog.Visible = false;
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         FProcessorWindowDesc.BaseActivity = this.FGoldTree;
         super.ProcessorOnOpenDesc();
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(1,null);
      }
      
      protected function ProcessorOnTreeOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         _loc4_ = this.FGoldTree.TreeList[_loc2_];
         if(_loc4_.Count == 0)
         {
            _loc3_ = this.FGoldTree.DescListNew[12];
         }
         else if(this.FGoldTree.ReturnType == TBaseActivity.RETURN_GOLD)
         {
            _loc3_ = TUtilityString.Format(this.FGoldTree.DescListNew[13],_loc4_.Count);
         }
         else
         {
            _loc3_ = TUtilityString.Format(this.FGoldTree.DescListNew[19],_loc4_.Count);
         }
         ProcessorOnShowHtmlText(_loc3_);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorFebActiveWaterLog.Load();
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
         PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         this.visible = false;
         this.FIsOpen = false;
         TweenUtil.removeAllTween();
         super.Unmount();
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
         this.FUnstreamizerGoldTree.Unstreamize(_loc2_,this.FGoldTree,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         if(this.FGoldTree)
         {
            this.FGoldTree.TotalRecharge = _loc2_.readUnsignedInt();
            this.FGoldTree.ConsumeGold = _loc2_.readUnsignedInt();
            this.FGoldTree.RechargeAddTimes = _loc2_.readUnsignedInt();
            this.FGoldTree.ConsumeAddTimes = _loc2_.readUnsignedInt();
            this.FGoldTree.WaterCount = _loc2_.readUnsignedInt();
            this.FGoldTree.RechargeGold = _loc2_.readUnsignedInt();
            if(this.FIsOpen)
            {
               this.UpdateUI();
            }
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
         ProcessorUnstreamActivityLog(this.FGoldTree,_loc2_);
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
         var _loc19_:int = 0;
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
            case ACTIVITY_2_WATER:
               --this.FGoldTree.WaterCount;
               _loc14_ = _loc2_.readUnsignedInt();
               _loc11_ = _loc2_.readUnsignedInt();
               _loc12_ = _loc2_.readUnsignedInt();
               this.FGoldTree.CurTreeLevel = _loc2_.readUnsignedInt();
               this.FGoldTree.CurTreeValue = _loc2_.readUnsignedInt();
               _loc5_ = 0;
               while(_loc5_ < this.FGoldTree.ReturnList.length)
               {
                  this.FGoldTree.ReturnList[_loc5_].Count = _loc2_.readUnsignedInt();
                  _loc5_++;
               }
               _loc4_ = this.FGoldTree.DescListNew[14] + "\n";
               _loc4_ = _loc4_ + STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc4_ = _loc4_ + (STRING_COMMON.GetItemNameByType(_loc14_,_loc11_) + "*" + _loc12_);
               ProcessorEffectText(_loc4_);
               this.FGoldTree.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FGoldTree.CheckStatus());
               this.PlayMovie();
               break;
            case ACTIVITY_2_GET:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FGoldTree.ReturnList[_loc5_].Status = TBaseActivity.STATUS_GETED;
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET);
               this.FGoldTree.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FGoldTree.CheckStatus());
               this.UpdateUI();
         }
      }
      
      public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         this.FIsPlaying = true;
         this.FMovieType = param1;
         FMC_Scene.MC_Movie.visible = true;
         FMC_Scene.MC_Movie.gotoAndPlay(1);
         this.FTotalFrame = FMC_Scene.MC_Movie.totalFrames;
         FMC_Scene.BTN_Water.visible = false;
      }
      
      public function MovieEnd() : void
      {
         FMC_Scene.MC_Movie.visible = false;
         FMC_Scene.MC_Movie.stop();
         FMC_Scene.BTN_Water.visible = true;
         this.UpdateUI();
      }
      
      public function Test() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

