package Processors.Game.Lobby.Exercise.LoginGift
{
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.LoginGift.TLoginGift;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerLoginGift;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorLoginGift extends TProcessorBaseActivity
   {
      
      protected static const SIGN_COUNT:int = 20;
      
      protected static const ITEM_COUNT:int = 3;
      
      public static const ACTIVITY_1_FREE_SIGN:int = 1;
      
      public static const ACTIVITY_1_GOLD_SIGN:int = 2;
      
      public static const ACTIVITY_1_BUY_FUND:int = 3;
      
      public static const ACTIVITY_1_BUY_ITEM:int = 4;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      protected var FIsPlaying:Boolean;
      
      protected var FWindowType:int;
      
      protected var FMovieType:int;
      
      protected var FOpenIndex:int;
      
      protected var FFrameCount:int;
      
      protected var FTotalFrame:int;
      
      protected var FPlayMovie:MovieClip;
      
      protected var FLoginGift:TLoginGift;
      
      protected var FUnstreamizerLoginGift:TUnstreamizerLoginGift;
      
      protected var FSignList:Vector.<TUIShowItem>;
      
      protected var FItemList:Vector.<TUIShowItem>;
      
      public function TProcessorLoginGift(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FLoginGift = SLogicsCore.LoginGift;
         this.FUnstreamizerLoginGift = new TUnstreamizerLoginGift();
         this.FBuyBoxDate = new Object();
         this.FSignList = new Vector.<TUIShowItem>(SIGN_COUNT);
         this.FItemList = new Vector.<TUIShowItem>(ITEM_COUNT);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TUIShowItem = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < SIGN_COUNT)
         {
            _loc5_ = new TUIShowItem(this,1);
            _loc5_.Perform_UIDispatch(FMC_Scene.MC_Days["day_" + _loc1_]);
            _loc5_.OnOverlay = UIComponentsHintOnOver;
            _loc5_.OnOut = UIComponentsHintOnOut;
            _loc5_.OnClick = this.ProcessorOnSlotUp;
            _loc5_.BoxIndex = _loc1_;
            this.FSignList[_loc1_] = _loc5_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < ITEM_COUNT)
         {
            _loc5_ = new TUIShowItem(this,1);
            _loc5_.Perform_UIDispatch(FMC_Scene["MC_Item" + _loc1_]);
            _loc5_.OnOverlay = UIComponentsHintOnOver;
            _loc5_.OnOut = UIComponentsHintOnOut;
            this.FItemList[_loc1_] = _loc5_;
            TGameUtil.setButtonMode(FMC_Scene["MC_Item" + _loc1_].BTN_Buy,true);
            FMC_Scene["MC_Item" + _loc1_].BTN_Buy.addEventListener(MouseEvent.CLICK,this.PrcoessorOnItemUp);
            _loc1_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.BTN_Sign,true);
         FMC_Scene.BTN_Sign.addEventListener(MouseEvent.CLICK,this.PrcoessorOnSignUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,true);
         FMC_Scene.BTN_Buy.addEventListener(MouseEvent.CLICK,this.PrcoessorOnFundUp);
         FMC_Scene.MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.PrcoessorOnFundOver);
         FMC_Scene.MC_Box.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
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
         if(Boolean(FMC_Scene) && FMC_Scene.visible)
         {
            if(this.FSignList)
            {
               _loc1_ = 0;
               while(_loc1_ < this.FSignList.length)
               {
                  if(this.FSignList[_loc1_])
                  {
                     this.FSignList[_loc1_].LogicsPerform();
                  }
                  _loc1_++;
               }
            }
            if(this.FItemList)
            {
               _loc1_ = 0;
               while(_loc1_ < this.FItemList.length)
               {
                  if(this.FItemList[_loc1_])
                  {
                     this.FItemList[_loc1_].LogicsPerform();
                  }
                  _loc1_++;
               }
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateSign();
         this.UpdateFund();
         this.UpdateItems();
         this.UpdateText();
      }
      
      protected function UpdateSign() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TBaseBox = null;
         var _loc6_:MovieClip = null;
         var _loc7_:TInventory = null;
         _loc1_ = 0;
         while(_loc1_ < SIGN_COUNT)
         {
            _loc6_ = FMC_Scene.MC_Days["day_" + _loc1_];
            _loc5_ = this.FLoginGift.SignList[_loc1_];
            this.FSignList[_loc1_].UpdateUI(_loc5_.Inventories);
            if(_loc5_.Level == 0)
            {
               _loc6_.MC_Buff.visible = false;
            }
            else
            {
               _loc6_.MC_Buff.visible = true;
               _loc6_.MC_Buff.TF_Buff.text = TUtilityString.Format(this.FLoginGift.DescListNew[4],_loc5_.Level);
            }
            if(this.FLoginGift.SignStatus == TBaseActivity.STATUS_CANGET)
            {
               if(_loc1_ == this.FLoginGift.CurSign - 1)
               {
                  _loc6_.MC_Selcet.visible = true;
               }
               else
               {
                  _loc6_.MC_Selcet.visible = false;
               }
            }
            else if(_loc1_ == this.FLoginGift.CurSign)
            {
               _loc6_.MC_Selcet.visible = true;
            }
            else
            {
               _loc6_.MC_Selcet.visible = false;
            }
            if(this.FLoginGift.SignStatus == TBaseActivity.STATUS_CANGET)
            {
               if(_loc1_ < this.FLoginGift.CurSign - 1)
               {
                  _loc6_.filters = [];
                  _loc6_.MC_Got.visible = true;
                  _loc6_.MC_Click.visible = false;
               }
               else if(_loc1_ == this.FLoginGift.CurSign - 1)
               {
                  _loc6_.filters = [];
                  _loc6_.MC_Got.visible = false;
                  _loc6_.MC_Click.visible = true;
               }
               else if(_loc1_ < this.FLoginGift.MaxSign)
               {
                  _loc6_.filters = [];
                  _loc6_.MC_Got.visible = false;
                  _loc6_.MC_Click.visible = false;
               }
               else
               {
                  _loc6_.filters = [TGameUtil.GaryColorFilters];
                  _loc6_.MC_Got.visible = false;
                  _loc6_.MC_Click.visible = false;
               }
            }
            else if(_loc1_ < this.FLoginGift.CurSign)
            {
               _loc6_.filters = [];
               _loc6_.MC_Got.visible = true;
               _loc6_.MC_Click.visible = false;
            }
            else if(_loc1_ < this.FLoginGift.MaxSign)
            {
               _loc6_.filters = [];
               _loc6_.MC_Got.visible = false;
               _loc6_.MC_Click.visible = false;
            }
            else
            {
               _loc6_.filters = [TGameUtil.GaryColorFilters];
               _loc6_.MC_Got.visible = false;
               _loc6_.MC_Click.visible = false;
            }
            _loc1_++;
         }
         if(this.FLoginGift.CurSign < this.FLoginGift.MaxSign && this.FLoginGift.SignStatus == TBaseActivity.STATUS_GETED)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Sign,true);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Sign,false);
         }
      }
      
      protected function UpdateFund() : void
      {
         if(this.FLoginGift.Fund.Status == TBaseActivity.STATUS_GETED)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,false);
            FMC_Scene.BTN_Buy.visible = false;
            FMC_Scene.MC_Got.visible = true;
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,true);
            FMC_Scene.BTN_Buy.visible = true;
            FMC_Scene.MC_Got.visible = false;
         }
      }
      
      protected function UpdateItems() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TBaseBox = null;
         var _loc6_:MovieClip = null;
         var _loc7_:TInventory = null;
         _loc1_ = 0;
         while(_loc1_ < ITEM_COUNT)
         {
            _loc6_ = FMC_Scene["MC_Item" + _loc1_];
            _loc5_ = this.FLoginGift.Itemlist[_loc1_];
            this.FItemList[_loc1_].UpdateUI(_loc5_.Inventories);
            _loc7_ = _loc5_.Inventories.GetInventoryByIndex(0);
            if(_loc7_.LimitCount > 0)
            {
               TGameUtil.setButtonMode(_loc6_.BTN_Buy,true);
            }
            else
            {
               TGameUtil.setButtonMode(_loc6_.BTN_Buy,false);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         FMC_Scene.TF_Desc.text = this.FLoginGift.DescListNew[1];
         FMC_Scene.TF_Desc1.text = this.FLoginGift.DescListNew[2];
         FMC_Scene.TF_Desc2.text = this.FLoginGift.DescListNew[3];
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FLoginGift.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FLoginGift.EndTime) - 1) * 1000)));
         if(this.FLoginGift.SignStatus == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.TF_Count.text = this.FLoginGift.CurSign - 1;
         }
         else
         {
            FMC_Scene.TF_Count.text = this.FLoginGift.CurSign;
         }
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function PrcoessorOnSignUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FLoginGift)
         {
            this.ProcessorOnBuyBoxUp(ACTIVITY_1_GOLD_SIGN,this.FLoginGift.SignPrice);
         }
      }
      
      protected function ProcessorOnSlotUp(param1:Object, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:TUIShowItem = null;
         _loc4_ = param1 as TUIShowItem;
         if(Boolean(this.FLoginGift) && Boolean(this.FLoginGift.CurSign - 1 == _loc4_.BoxIndex) && this.FLoginGift.SignStatus == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_FREE_SIGN);
         }
      }
      
      protected function PrcoessorOnFundUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FLoginGift)
         {
            this.ProcessorOnBuyBoxUp(ACTIVITY_1_BUY_FUND,this.FLoginGift.Fund.Price);
         }
      }
      
      protected function PrcoessorOnItemUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(this.FLoginGift) && _loc2_ < this.FLoginGift.Itemlist.length)
         {
            _loc3_ = this.FLoginGift.Itemlist[_loc2_].Inventories.GetInventoryByIndex(0).MinPrice;
            this.ProcessorOnBuyBoxUp(ACTIVITY_1_BUY_ITEM,_loc3_,_loc2_ + 1);
         }
      }
      
      protected function PrcoessorOnFundOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(Boolean(this.FLoginGift) && Boolean(this.FLoginGift.Fund))
         {
            ProcessorOnNewBoxOver(this.FLoginGift.Fund.Inventories);
         }
      }
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:String = "", param6:int = 0, param7:int = 0) : void
      {
         if(this.FBeClicked || this.FIsPlaying)
         {
            return;
         }
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
         if(this.FBeClicked || this.FIsPlaying)
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
      
      override protected function ProcessorOnOpenDesc(param1:MouseEvent = null) : void
      {
         FProcessorWindowDesc.BaseActivity = this.FLoginGift;
         super.ProcessorOnOpenDesc();
      }
      
      override protected function PerformPacket_CS_LoadLogReq(param1:MouseEvent = null) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(1,null);
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
         TweenUtil.removeAllTween();
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
         this.FUnstreamizerLoginGift.Unstreamize(_loc2_,this.FLoginGift,null);
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
         if(this.FLoginGift)
         {
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
         ProcessorUnstreamActivityLog(this.FLoginGift,_loc2_);
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
         var _loc20_:uint = 0;
         var _loc21_:Vector.<uint> = null;
         var _loc22_:Vector.<uint> = null;
         var _loc23_:String = null;
         var _loc24_:TDessertHouseTask = null;
         var _loc25_:int = 0;
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
            case ACTIVITY_1_FREE_SIGN:
               this.FLoginGift.SignStatus = TBaseActivity.STATUS_GETED;
               ProcessorEffectText(this.FLoginGift.DescListNew[5]);
               ProcessorCheckEffect(FActivityID,this.FLoginGift.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_GOLD_SIGN:
               ++this.FLoginGift.CurSign;
               ProcessorEffectText(this.FLoginGift.DescListNew[5]);
               ProcessorCheckEffect(FActivityID,this.FLoginGift.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_BUY_FUND:
               this.FLoginGift.Fund.Status = TBaseActivity.STATUS_GETED;
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED);
               ProcessorCheckEffect(FActivityID,this.FLoginGift.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_BUY_ITEM:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               --this.FLoginGift.Itemlist[_loc5_].Inventories.GetInventoryByIndex(0).LimitCount;
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED);
               ProcessorCheckEffect(FActivityID,this.FLoginGift.CheckStatus());
               this.UpdateUI();
         }
      }
      
      public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         var _loc6_:TInventory = null;
         var _loc7_:String = null;
         this.FIsPlaying = true;
         this.FMovieType = param1;
      }
      
      public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         this.FIsPlaying = false;
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

