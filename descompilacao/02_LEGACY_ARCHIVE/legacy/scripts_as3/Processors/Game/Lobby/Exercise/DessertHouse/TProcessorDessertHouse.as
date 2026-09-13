package Processors.Game.Lobby.Exercise.DessertHouse
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Exercise.DessertHouse.TDessertHouse;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerActivityTask;
   import Logics.Streamization.Exercise.TUnstreamizerDessertHouse;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.Streamization.Title.TUnstreamizerTitle;
   import Logics.Title.TTitle;
   import Logics.Title.TTitles;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlowTwo;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.DessertHouse.Compoents.TUIDessertHouse1;
   import Processors.Game.Lobby.Exercise.DessertHouse.Compoents.TUIDessertHouse2;
   import Processors.Game.Lobby.Exercise.DessertHouse.Compoents.TUIDessertHouse3;
   import Rendering.Overlayers.Title.TOverlayerTitle;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorDessertHouse extends TProcessorBaseActivity
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_3_ID:int = 3;
      
      public static const ACTIVITY_1_MAKE_CAKE:int = 1;
      
      public static const ACTIVITY_1_BUY_FOOD:int = 2;
      
      public static const ACTIVITY_1_GET_SERVER_BOX:int = 3;
      
      public static const ACTIVITY_3_EXCHANGE_ITEM:int = 4;
      
      public static const ACTIVITY_2_GET_TASK:int = 1;
      
      public static const ACTIVITY_2_FINISH_TASK:int = 2;
      
      public static const ACTIVITY_2_RESET_TASK:int = 3;
      
      public static const ACTIVITY_2_GET_TASK_BOX:int = 4;
      
      public static const FilterColor:uint = 15911245;
      
      public static const FilterGlowWidth:int = 2;
      
      public static const FilterGlowStrength:int = 10;
      
      protected var TAB_COUNT:int = 3;
      
      protected var ACTIVITY_REFERENCE:Vector.<Class> = Vector.<Class>([TUIDessertHouse1,TUIDessertHouse2,TUIDessertHouse3]);
      
      protected var FIsOpen:Boolean;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FCost:int;
      
      protected var FTabList:Vector.<MovieClip>;
      
      protected var FChangeTabIndex:int;
      
      protected var FGlowsFilter:Vector.<TEffectBaseGlowTwo>;
      
      protected var FUIWindowVect:Vector.<TUIBaseWindow>;
      
      protected var FCakeIndex:int;
      
      protected var FBuyBoxDate:Object;
      
      protected var FDessertHouse:TDessertHouse;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      protected var FUnstreamizerDessertHouse:TUnstreamizerDessertHouse;
      
      protected var FUnstreamizerActivityTask:TUnstreamizerActivityTask;
      
      protected var FOverlayerTitle:TOverlayerTitle;
      
      protected var FAllTitles:TTitles;
      
      protected var FUnstreamizerTitle:TUnstreamizerTitle;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FProcessoDessertHouseMake:TProcessoDessertHouseMake;
      
      public function TProcessorDessertHouse(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FDessertHouse = SLogicsCore.DessertHouse;
         this.FActivityTaskData = SLogicsCore.ActivityTaskData;
         this.FUnstreamizerDessertHouse = new TUnstreamizerDessertHouse();
         this.FUnstreamizerActivityTask = new TUnstreamizerActivityTask(param3);
         this.FTabList = new Vector.<MovieClip>(this.TAB_COUNT);
         this.FChangeTabIndex = 0;
         this.FGlowsFilter = new Vector.<TEffectBaseGlowTwo>(this.TAB_COUNT);
         this.FUIWindowVect = new Vector.<TUIBaseWindow>(this.TAB_COUNT);
         this.FBuyBoxDate = new Object();
         this.FOverlayerTitle = new TOverlayerTitle(this.Parent);
         this.FOverlayerTitle.Visible = false;
         this.FUnstreamizerTitle = new TUnstreamizerTitle();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FAllTitles = new TTitles();
         this.FProcessoDessertHouseMake = new TProcessoDessertHouseMake(this.Parent);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:Class = null;
         var _loc5_:TEffectBaseGlowTwo = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < this.TAB_COUNT)
         {
            this.FTabList[_loc1_] = FMC_Scene["MC_Tab" + _loc1_];
            TGameUtil.setButtonMode(this.FTabList[_loc1_],true);
            this.FTabList[_loc1_].addEventListener(MouseEvent.CLICK,this.ProcessorOnChangePage);
            _loc5_ = new TEffectBaseGlowTwo();
            _loc5_.SetParameters(FMC_Scene["MC_Tab" + _loc1_],FilterColor,FilterGlowWidth,FilterGlowStrength);
            this.FGlowsFilter[_loc1_] = _loc5_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.TAB_COUNT)
         {
            _loc4_ = this.ACTIVITY_REFERENCE[_loc1_];
            this.FUIWindowVect[_loc1_] = new _loc4_(this);
            this.FUIWindowVect[_loc1_].Perform_UIDispatch(FMC_Scene["MC_Activity" + _loc1_]);
            this.FUIWindowVect[_loc1_].OnGetBox = this.ProcessorOnGetBoxUp;
            this.FUIWindowVect[_loc1_].OnBuyBox = this.ProcessorOnBuyBoxUp;
            this.FUIWindowVect[_loc1_].OnNewBoxOver = ProcessorOnNewBoxOver;
            this.FUIWindowVect[_loc1_].OnNewBoxOut = ProcessorOnNewBoxOut;
            this.FUIWindowVect[_loc1_].OnItemOver = UIComponentsHintOnOver;
            this.FUIWindowVect[_loc1_].OnItemOut = UIComponentsHintOnOut;
            this.FUIWindowVect[_loc1_].OnShowHtmlTip = ProcessorOnShowHtmlText;
            this.FUIWindowVect[_loc1_].OnHideHtmlTip = ProcessorOnHideHtmlText;
            this.FUIWindowVect[_loc1_].OnShowFlowText = ProcessorEffectText;
            this.FUIWindowVect[_loc1_].OnLoadLog = this.ProcessorOnLoadLog;
            this.FUIWindowVect[_loc1_].GotoRecharge = ProcessorOnRechargeUp;
            this.FUIWindowVect[_loc1_].OnShowWindow = this.ProcessorOnShowWindow;
            this.FUIWindowVect[_loc1_].OnCloseWindow = this.ProcessorOnCloseWindow;
            this.FUIWindowVect[_loc1_].OnGoto = ProcessorOnGoto;
            _loc1_++;
         }
         this.FProcessoDessertHouseMake.OnCloseUp = this.ProcessorOnHideWindow;
         this.FProcessoDessertHouseMake.OnGetBox = this.ProcessorOnGetBoxUp;
         this.FProcessoDessertHouseMake.OnBuyBox = this.ProcessorOnBuyBoxUp;
         this.FProcessoDessertHouseMake.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTitle);
         this.FUnstreamizerTitle.UnstreamizeTitleByDatabase(null,this.FAllTitles,null);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && FMC_Scene.visible)
         {
            this.UpdateTabEffect();
            this.FUIWindowVect[this.FChangeTabIndex].LogicsPerform();
         }
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseActivity = null;
         super.UpdateUI();
         _loc1_ = 0;
         while(_loc1_ < this.TAB_COUNT)
         {
            _loc2_ = this.FTabList[_loc1_];
            if(_loc1_ == this.FChangeTabIndex)
            {
               this.FUIWindowVect[_loc1_].SetVisible(true);
               this.FUIWindowVect[_loc1_].UpdateUI();
            }
            else
            {
               this.FUIWindowVect[_loc1_].SetVisible(false);
            }
            if(_loc1_ == 1)
            {
               if(this.FActivityTaskData.NeedShine == TBaseActivity.STATUS_CANGET)
               {
                  this.FGlowsFilter[_loc1_].IsRunOver = false;
               }
               else
               {
                  this.FGlowsFilter[_loc1_].Stop();
               }
            }
            else if(this.FDessertHouse.CheckTabStatus(_loc1_))
            {
               this.FGlowsFilter[_loc1_].IsRunOver = false;
            }
            else
            {
               this.FGlowsFilter[_loc1_].Stop();
            }
            _loc1_++;
         }
         if(this.FProcessoDessertHouseMake.Visible)
         {
            this.FProcessoDessertHouseMake.UpdateUI(this.FCakeIndex);
         }
         this.UpdateText();
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FDessertHouse.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FDessertHouse.EndTime) - 1) * 1000)));
         if(this.FChangeTabIndex == 1)
         {
            FMC_Scene.TF_Desc.text = this.FActivityTaskData.DescList[1];
         }
         else
         {
            FMC_Scene.TF_Desc.text = this.FDessertHouse.DescListNew[1];
         }
      }
      
      protected function UpdateTabEffect() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TEffectBaseGlowTwo = null;
         if(this.FGlowsFilter == null || this.FGlowsFilter[0] == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FGlowsFilter.length)
         {
            _loc2_ = this.FGlowsFilter[_loc1_];
            if(!_loc2_.IsRunOver)
            {
               _loc2_.Run();
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorOnChangePage(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseActivity = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         this.FChangeTabIndex = _loc2_;
         this.PerformPacket_CS_LoadInfoReq();
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_HappyTreasure_LoadInfoReq);
         _loc1_.Data.writeUnsignedInt(ActivityID);
         _loc1_.Data.writeUnsignedInt(this.FChangeTabIndex + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int, param4:int = 0, param5:int = 0, param6:String = "", param7:int = 1) : void
      {
         this.FBuyBoxDate.ActivityType = param1;
         this.FBuyBoxDate.BoxType = param2;
         this.FBuyBoxDate.BoxIndex = param4;
         this.FBuyBoxDate.Cost = param3;
         this.FBuyBoxDate.CostType = param5;
         this.FBuyBoxDate.BuyCount = param7;
         if(param5 != TBaseActivity.SWEET_TYPE_GOLD)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BuyCount);
            return;
         }
         if(!FUIWindowConfirmation.IsSelected)
         {
            this.FCost = param3;
            if(param6 != "")
            {
               FUIWindowConfirmation.Text = param6;
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
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BuyCount);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 1) : void
      {
         var _loc5_:TPacket = null;
         var _loc6_:int = 0;
         var _loc7_:Vector.<int> = null;
         if(this.FBeClicked)
         {
            return;
         }
         this.FBeClicked = true;
         _loc7_ = new Vector.<int>();
         _loc7_.push(param2);
         if(param3 != 0)
         {
            _loc7_.push(param3);
         }
         if(param4 > 0)
         {
            _loc7_.push(param4);
         }
         PerformPacket_CS_AllReq(param1,_loc7_);
      }
      
      protected function ProcessorOnTitleOver(param1:uint) : void
      {
         var _loc2_:TTitle = null;
         _loc2_ = this.FAllTitles.GetTitleByIdentifier(param1);
         if(_loc2_ != null)
         {
            this.FOverlayerTitle.Context = _loc2_;
            this.FOverlayerTitle.Render(FUICore.MouseCoordinate);
            this.FOverlayerTitle.Show();
         }
      }
      
      protected function ProcessorOnTitleOut() : void
      {
         this.FOverlayerTitle.Hide();
      }
      
      protected function ProcessorOnLoadLog(param1:int) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(param1,null);
      }
      
      protected function ProcessorOnShowWindow(param1:int) : void
      {
         switch(param1)
         {
            case 0:
            case 1:
            case 2:
               this.FProcessoDessertHouseMake.Visible = true;
               this.FProcessoDessertHouseMake.UpdateUI(param1);
               break;
            case 3:
         }
      }
      
      protected function ProcessorOnHideWindow() : void
      {
         this.FProcessoDessertHouseMake.Visible = false;
      }
      
      protected function ProcessorOnCloseWindow() : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      override protected function ProcessorOnOpenDesc(param1:MouseEvent = null) : void
      {
         if(this.FChangeTabIndex == 1)
         {
            FProcessorWindowDesc.BaseActivity = this.FDessertHouse as TActivityTaskData;
         }
         else
         {
            FProcessorWindowDesc.BaseActivity = this.FDessertHouse as TBaseActivity;
         }
         super.ProcessorOnOpenDesc();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessoDessertHouseMake.Load();
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
         this.FChangeTabIndex = 0;
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.visible = false;
         this.FIsOpen = false;
         if(this.FUIWindowVect[0])
         {
            this.FUIWindowVect[0].Unmount();
         }
         TweenUtil.removeAllTween();
         this.FChangeTabIndex = 0;
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
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
            OnClose(this);
            return;
         }
         this.FUnstreamizerDessertHouse.Unstreamize(_loc2_,this.FDessertHouse,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorOnLoadTaskInfoRet(param1:TPacket = null) : void
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
            OnClose(this);
            return;
         }
         this.FUnstreamizerActivityTask.Unstreamize(_loc2_,this.FActivityTaskData,null);
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
         ProcessorUnstreamActivityLog(this.FDessertHouse,_loc2_);
      }
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         _loc3_ = _loc2_.readInt();
         switch(_loc3_)
         {
            case ACTIVITY_1_ID:
               break;
            case ACTIVITY_2_ID:
               this.FActivityTaskData.NeedShine = _loc2_.readUnsignedInt();
               break;
            case ACTIVITY_3_ID:
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
         var _loc10_:TInventory = null;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:int = 0;
         var _loc15_:uint = 0;
         var _loc16_:TBaseBox = null;
         var _loc17_:uint = 0;
         var _loc18_:TBins = null;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:Vector.<Object> = null;
         var _loc24_:TConfigValue = null;
         var _loc25_:int = 0;
         var _loc26_:int = 0;
         var _loc27_:int = 0;
         var _loc28_:TDessertHouseTask = null;
         this.FBeClicked = false;
         _loc18_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         _loc24_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.DROP_ITEM_NAME) as TConfigValue;
         _loc23_ = _loc24_.Value as Vector.<Object>;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         switch(_loc7_)
         {
            case ACTIVITY_1_ID:
               _loc2_.readShort();
               _loc11_ = _loc2_.readUnsignedInt();
               if(_loc11_ == ACTIVITY_1_BUY_FOOD)
               {
                  this.FDessertHouse.FoodBox.Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < this.FDessertHouse.FoodBox.Inventories.Count)
                  {
                     _loc9_ = this.FDessertHouse.FoodBox.Inventories.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc10_ = this.FDessertHouse.MyFood.GetInventoryByTempletID(_loc9_.IDTemplate);
                     _loc10_.Quantity += _loc9_.Quantity;
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  this.FDessertHouse.ChangeStatus();
                  ProcessorCheckEffect(FActivityID,this.FDessertHouse.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc11_ == ACTIVITY_1_MAKE_CAKE)
               {
                  this.FCakeIndex = _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc15_ = _loc2_.readUnsignedInt();
                  this.FDessertHouse.ServerBox.BuyCount = _loc2_.readUnsignedInt();
                  this.FDessertHouse.TastyValue += _loc15_;
                  _loc16_ = this.FDessertHouse.MakeFoods[_loc5_];
                  _loc4_ = TUtilityString.Format(this.FDessertHouse.DescListNew[5],_loc15_);
                  _loc5_ = 0;
                  while(_loc5_ < this.FDessertHouse.MyFood.Count)
                  {
                     _loc9_ = this.FDessertHouse.MyFood.GetInventoryByIndex(_loc5_);
                     _loc9_.Quantity = _loc2_.readUnsignedInt();
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  if(this.FProcessoDessertHouseMake.Visible)
                  {
                     this.FProcessoDessertHouseMake.UpdateText();
                  }
                  this.FDessertHouse.ChangeStatus();
                  ProcessorCheckEffect(FActivityID,this.FDessertHouse.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc11_ == ACTIVITY_1_GET_SERVER_BOX)
               {
                  this.FDessertHouse.ServerBox.Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < this.FDessertHouse.ServerBox.Inventories.Count)
                  {
                     _loc9_ = this.FDessertHouse.ServerBox.Inventories.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  this.FDessertHouse.ChangeStatus();
                  ProcessorCheckEffect(FActivityID,this.FDessertHouse.CheckStatus());
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_2_ID:
               _loc2_.readShort();
               _loc11_ = _loc2_.readUnsignedInt();
               if(_loc11_ == ACTIVITY_2_GET_TASK)
               {
                  _loc13_ = _loc2_.readUnsignedInt();
                  _loc28_ = this.FActivityTaskData.GetTaskByIdentify(_loc13_);
                  if(_loc28_ != null)
                  {
                     _loc28_.Status = TBaseActivity.STATUS_CANGET;
                     ProcessorEffectText(this.FActivityTaskData.DescList[2]);
                  }
                  this.FDessertHouse.ChangeStatus();
                  ProcessorCheckEffect(FActivityID,this.FDessertHouse.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc11_ == ACTIVITY_2_FINISH_TASK)
               {
                  _loc13_ = _loc2_.readUnsignedInt();
                  _loc28_ = this.FActivityTaskData.GetTaskByIdentify(_loc13_);
                  if(_loc28_ != null)
                  {
                     this.FActivityTaskData.Score += _loc28_.TaskPoint[_loc28_.Step];
                     this.FActivityTaskData.ChangeStatus();
                     _loc4_ = TUtilityString.Format(this.FActivityTaskData.DescList[3],_loc28_.TaskPoint[_loc28_.Step]);
                     _loc4_ = _loc4_ + STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                     _loc5_ = 0;
                     while(_loc5_ < _loc28_.TaskAward[_loc28_.Step].Count)
                     {
                        _loc9_ = _loc28_.TaskAward[_loc28_.Step].GetInventoryByIndex(_loc5_);
                        _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                        _loc5_++;
                     }
                     ++_loc28_.Step;
                     _loc28_.Process = 0;
                     if(_loc28_.Step >= 3)
                     {
                        _loc28_.Status = TBaseActivity.STATUS_GETED;
                     }
                     else
                     {
                        _loc28_.Status = TBaseActivity.STATUS_CANNOTGET;
                     }
                     ProcessorEffectText(_loc4_);
                     this.FUIWindowVect[1].PlayMovie();
                  }
                  this.FActivityTaskData.NeedShine = _loc2_.readUnsignedInt();
                  this.FDessertHouse.ChangeStatus();
                  ProcessorCheckEffect(FActivityID,this.FDessertHouse.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc11_ == ACTIVITY_2_RESET_TASK)
               {
                  _loc13_ = _loc2_.readUnsignedInt();
                  _loc28_ = this.FActivityTaskData.GetTaskByIdentify(_loc13_);
                  if(_loc28_ != null)
                  {
                     _loc28_.Step = 0;
                     --_loc28_.Reset;
                     _loc28_.Status = TBaseActivity.STATUS_CANNOTGET;
                     _loc28_.Process = 0;
                  }
                  ProcessorEffectText(this.FActivityTaskData.DescList[4]);
                  this.FDessertHouse.ChangeStatus();
                  ProcessorCheckEffect(FActivityID,this.FDessertHouse.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc11_ == ACTIVITY_2_GET_TASK_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  this.FActivityTaskData.BoxList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc8_ = this.FActivityTaskData.BoxList[_loc5_].Inventories;
                  _loc5_ = 0;
                  while(_loc5_ < _loc8_.Count)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  this.FDessertHouse.ChangeStatus();
                  ProcessorCheckEffect(FActivityID,this.FDessertHouse.CheckStatus());
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_3_ID:
               _loc2_.readShort();
               _loc11_ = _loc2_.readUnsignedInt();
               if(_loc11_ == ACTIVITY_3_EXCHANGE_ITEM)
               {
                  _loc13_ = _loc2_.readUnsignedInt();
                  this.FDessertHouse.CakeLevel = _loc2_.readUnsignedInt();
                  this.FDessertHouse.CakeExp = _loc2_.readUnsignedInt();
                  this.FDessertHouse.CakeNextExp = _loc2_.readUnsignedInt();
                  _loc15_ = _loc2_.readUnsignedInt();
                  _loc16_ = this.FDessertHouse.GetItemByIdentify(_loc13_);
                  if(_loc16_)
                  {
                     this.FDessertHouse.TastyValue -= _loc16_.Price;
                     --_loc16_.LimitCount;
                     _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
                     _loc4_ = _loc4_ + TUtilityString.Format(this.FDessertHouse.DescListNew[4],_loc15_);
                     ProcessorEffectText(_loc4_);
                     this.FUIWindowVect[2].PlayMovie(_loc13_);
                  }
                  this.FDessertHouse.ChangeStatus();
                  ProcessorCheckEffect(FActivityID,this.FDessertHouse.CheckStatus());
               }
         }
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeUnsignedInt(0);
         _loc4_.writeUnsignedInt(1371571200);
         _loc4_.writeUnsignedInt(1401571200);
         _loc4_.writeShort(6);
         TUtilityString.FlushUTF(_loc4_,"活动说明长");
         TUtilityString.FlushUTF(_loc4_,"活动说明短");
         TUtilityString.FlushUTF(_loc4_,"制作当前美食可获得%0点美味值");
         TUtilityString.FlushUTF(_loc4_,"%0缺少%1个(单价:%2金币),");
         TUtilityString.FlushUTF(_loc4_,"确定花费%0金币补齐?");
         TUtilityString.FlushUTF(_loc4_,"制作成功，获得%0点美味值");
         _loc4_.writeUnsignedInt(1);
         _loc4_.writeUnsignedInt(500);
         _loc4_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc4_.writeUnsignedInt(1);
            _loc4_.writeUnsignedInt(14100003 + _loc1_);
            _loc4_.writeUnsignedInt(10);
            _loc1_++;
         }
         _loc4_.writeInt(1);
         _loc4_.writeUnsignedInt(5000);
         _loc4_.writeUnsignedInt(5000);
         _loc4_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc4_.writeUnsignedInt(1);
            _loc4_.writeUnsignedInt(14100003 + _loc1_);
            _loc4_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc4_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc2_ = int(STimingCore.GetServerTime());
            _loc4_.writeUnsignedInt(_loc2_);
            TUtilityString.FlushUTF(_loc4_,"name" + _loc1_);
            _loc1_++;
         }
         _loc4_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc2_ = int(STimingCore.GetServerTime());
            _loc4_.writeUnsignedInt(_loc2_);
            TUtilityString.FlushUTF(_loc4_,"name" + _loc1_);
            _loc1_++;
         }
         _loc4_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc4_.writeUnsignedInt(1);
            _loc4_.writeUnsignedInt(14100003 + _loc1_);
            _loc4_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc4_.writeInt(1);
         _loc4_.writeUnsignedInt(10);
         _loc4_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc4_.writeUnsignedInt(1);
            _loc4_.writeUnsignedInt(14100003 + _loc1_);
            _loc4_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc4_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc4_.writeUnsignedInt(1 + _loc1_);
            _loc1_++;
         }
         _loc4_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            TUtilityString.FlushUTF(_loc4_,"CAKE" + _loc1_);
            _loc4_.writeUnsignedInt(1 + _loc1_);
            _loc4_.writeShort(3);
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               _loc4_.writeUnsignedInt(1 + _loc2_);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc4_.position = 0;
         return _loc4_;
      }
      
      public function TestInit1() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(5);
         TUtilityString.FlushUTF(_loc3_,"活动说明长");
         TUtilityString.FlushUTF(_loc3_,"活动说明短");
         TUtilityString.FlushUTF(_loc3_,"接取成功");
         TUtilityString.FlushUTF(_loc3_,"任务完成，积分增加%0点");
         TUtilityString.FlushUTF(_loc3_,"重置成功");
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeUnsignedInt(99);
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeUnsignedInt(1 + _loc1_);
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeUnsignedInt(8 + _loc1_);
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            TUtilityString.FlushUTF(_loc3_,"TIPS");
            _loc3_.writeInt(0);
            _loc3_.writeInt(20 * _loc1_ + 20);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
      
      public function TestInit2() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(7);
         TUtilityString.FlushUTF(_loc3_,"活动说明长");
         TUtilityString.FlushUTF(_loc3_,"活动说明短");
         TUtilityString.FlushUTF(_loc3_,"兑换需要%0点美味值");
         TUtilityString.FlushUTF(_loc3_,"Level%0级解锁");
         TUtilityString.FlushUTF(_loc3_,"蛋糕经验提升%0点");
         TUtilityString.FlushUTF(_loc3_,"美味值不足或剩余数量不足或蛋糕等级不足");
         TUtilityString.FlushUTF(_loc3_,"全服剩余%0个");
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeShort(27);
         _loc1_ = 0;
         while(_loc1_ < 27)
         {
            _loc3_.writeUnsignedInt(1 + _loc1_);
            _loc3_.writeUnsignedInt(_loc1_ / 9 + 1);
            _loc3_.writeInt(_loc1_ % 2);
            _loc3_.writeInt(_loc1_ + 1);
            _loc3_.writeInt(_loc1_ + 1);
            _loc3_.writeShort(1);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100003 + _loc1_);
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

