package Processors.Game.Lobby.Exercise.CloudBuy
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
   import Logics.Exercise.CloudBuy.TCloudBuy;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerCloudBuy;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorCloudBuy extends TProcessorBaseActivity
   {
      
      protected static const SHOW_ITEM_COUNT:int = 5;
      
      protected static const REQ_TYPE_BUY:int = 1;
      
      protected static const LOAD_NEWS_TIME:int = 5 * 60;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FCloudBuy:TCloudBuy;
      
      protected var FUnstreamizerCloudBuy:TUnstreamizerCloudBuy;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FProcessorCloudBuyLog:TProcessorCloudBuyLog;
      
      protected var FNextTimeID:int;
      
      protected var FNewsTimeID:int;
      
      protected var FInitX:int;
      
      protected var FEndX:int;
      
      protected var FLogIndex:int;
      
      protected var FNextNewsTime:int;
      
      public function TProcessorCloudBuy(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FCloudBuy = SLogicsCore.CloudBuy;
         this.FUnstreamizerCloudBuy = new TUnstreamizerCloudBuy();
         this.FBuyBoxDate = new Object();
         this.FProcessorCloudBuyLog = new TProcessorCloudBuyLog(this.Parent);
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowRecruit.y = (CONST_COMMON.STAGE_Height - 358) / 2;
         this.FEndX = 600;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItem);
         this.FShowItem.OnOverlay = UIComponentsHintOnOver;
         this.FShowItem.OnOut = UIComponentsHintOnOut;
         this.FShowItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         this.FProcessorCloudBuyLog.OnCloseUp = this.ProcessorOnCloseLogUp;
         this.FProcessorCloudBuyLog.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorCloudBuyLog.OnOut = UIComponentsHintOnOut;
         this.FProcessorCloudBuyLog.OnShowRecruit = this.ProcessorOnShowRecruit;
         this.FProcessorCloudBuyLog.Visible = false;
         this.FInitX = FMC_Scene.MC_News.MC_News.x - 50;
         FMC_Scene.MC_News.MC_News.TF_Text.text = "";
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         TGameUtil.setButtonMode(FMC_Scene.BTN_Last,true);
         FMC_Scene.BTN_Last.addEventListener(MouseEvent.CLICK,this.ProcessorOnLastUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.MC_Buy.BTN_Buy,true);
         FMC_Scene.MC_Buy.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyUp);
         FMC_Scene.MC_Buy.BTN_Buy.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBuyOver);
         FMC_Scene.MC_Buy.BTN_Buy.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && FMC_Scene.visible)
         {
            if(Boolean(this.FCloudBuy) && Boolean(FTF_Time))
            {
               FTF_Time.text = TGameUtil.fomatTime(this.FCloudBuy.NextTime - STimingCore.GetServerTick());
            }
            if(this.FProcessorWindowRecruit != null && this.FProcessorWindowRecruit.Visible == true)
            {
               this.FProcessorWindowRecruit.UpdataBitmap();
            }
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateShowItem();
         this.UpdateText();
      }
      
      protected function UpdateShowItem() : void
      {
         if(this.FCloudBuy.GameStatus != TCloudBuy.GAME_STATUS_3)
         {
            FMC_Scene.MC_Buy.visible = true;
            FMC_Scene.MC_Succeed.visible = false;
            FMC_Scene.MC_Lost.visible = false;
            if(this.FCloudBuy.GameStatus == TCloudBuy.GAME_STATUS_1 && this.FCloudBuy.MyCount > 0 || this.FCloudBuy.RemainCount == 0)
            {
               TGameUtil.setButtonMode(FMC_Scene.MC_Buy.BTN_Buy,false);
            }
            else
            {
               TGameUtil.setButtonMode(FMC_Scene.MC_Buy.BTN_Buy,true);
            }
         }
         else if(this.FCloudBuy.BuySuccess == 1)
         {
            FMC_Scene.MC_Buy.visible = false;
            FMC_Scene.MC_Succeed.visible = true;
            FMC_Scene.MC_Lost.visible = false;
            FMC_Scene.MC_Succeed.TF_Name.text = this.FCloudBuy.LuckyGuy;
         }
         else
         {
            FMC_Scene.MC_Buy.visible = false;
            FMC_Scene.MC_Succeed.visible = false;
            FMC_Scene.MC_Lost.visible = true;
         }
         this.FShowItem.UpdateUI(this.FCloudBuy.Items);
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Desc.text = this.FCloudBuy.DescListNew[1];
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FCloudBuy.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FCloudBuy.EndTime) - 1) * 1000)));
         FMC_Scene.TF_PriceDesc.text = TUtilityString.Format(this.FCloudBuy.DescListNew[2],this.FCloudBuy.ItemCost);
         if(this.FCloudBuy.GameStatus == TCloudBuy.GAME_STATUS_3)
         {
            FMC_Scene.TF_NextStatus.text = this.FCloudBuy.DescListNew[4];
         }
         else
         {
            FMC_Scene.MC_Buy.TF_Price.text = this.FCloudBuy.Price.toString();
            FMC_Scene.MC_Buy.TF_Num.text = this.FCloudBuy.MyCount.toString();
            FMC_Scene.TF_NextStatus.text = this.FCloudBuy.DescListNew[3];
         }
         FMC_Scene.TF_BoughtCount.text = this.FCloudBuy.BoughtCount.toString();
         FMC_Scene.TF_RemainCount.text = this.FCloudBuy.RemainCount.toString();
      }
      
      protected function SetEndTime() : void
      {
         var _loc1_:Number = NaN;
         if(this.FNextTimeID != 0)
         {
            clearTimeout(this.FNextTimeID);
            this.FNextTimeID = 0;
         }
         _loc1_ = (this.FCloudBuy.NextTime - STimingCore.GetServerTick()) * 1000;
         if(_loc1_ < 0)
         {
            return;
         }
         if(_loc1_ > int.MAX_VALUE)
         {
            _loc1_ = int.MAX_VALUE;
         }
         this.FNextTimeID = setTimeout(this.PerformPacket_CS_LoadInfoReq,_loc1_);
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function SetNextNewsTime() : void
      {
         var _loc1_:Number = NaN;
         if(this.FNewsTimeID != 0)
         {
            clearTimeout(this.FNewsTimeID);
            this.FNewsTimeID = 0;
         }
         _loc1_ = (this.FNextNewsTime - STimingCore.GetServerTick()) * 1000;
         if(_loc1_ < 0)
         {
            return;
         }
         if(_loc1_ > int.MAX_VALUE)
         {
            _loc1_ = int.MAX_VALUE;
         }
         this.FNextTimeID = setTimeout(this.PerformPacket_CS_LoadNewReq,_loc1_);
      }
      
      protected function PerformPacket_CS_LoadNewReq() : void
      {
         var _loc1_:Vector.<int> = null;
         _loc1_ = new Vector.<int>();
         PerformPacket_CS_AllReq(2,_loc1_);
      }
      
      protected function ProcessorOnLastUp(param1:MouseEvent) : void
      {
         if(this.FCloudBuy.LastItems)
         {
            this.FProcessorCloudBuyLog.UpdateUI();
            this.FProcessorCloudBuyLog.Visible = true;
         }
      }
      
      protected function ProcessorOnBuyUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode || this.FBeClicked)
         {
            return;
         }
         if(Boolean(this.FCloudBuy) && this.FCloudBuy.GameStatus != TCloudBuy.GAME_STATUS_3)
         {
            this.ProcessorOnBuyBoxUp(REQ_TYPE_BUY,this.FCloudBuy.Price);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         FProcessorWindowDesc.BaseActivity = this.FCloudBuy;
         super.ProcessorOnOpenDesc();
      }
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:String = "", param6:int = 0) : void
      {
         this.FBuyBoxDate.ActivityType = param1;
         this.FBuyBoxDate.Cost = param2;
         this.FBuyBoxDate.BoxIndex = param3;
         this.FBuyBoxDate.CostType = param4;
         this.FBuyBoxDate.BoxIndex1 = param6;
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
      
      protected function ProcessorOnBuyOver(param1:MouseEvent) : void
      {
         if(Boolean(this.FCloudBuy) && this.FCloudBuy.DescList.length > 5)
         {
            ProcessorOnShowHtmlText(this.FCloudBuy.DescListNew[5]);
         }
      }
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int = 0) : void
      {
         if(param2 == TBaseBox.TYPE_IS_HERO)
         {
            this.FProcessorWindowRecruit.SetHeroData(param1);
         }
         else if(param2 == TBaseBox.TYPE_IS_PET)
         {
            FProcessorWindowPetDesc.SetPetData(param1);
         }
      }
      
      protected function ProcessorOnCloseLogUp() : void
      {
         this.FProcessorCloudBuyLog.Visible = false;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowRecruit.Load();
            this.FProcessorCloudBuyLog.Load();
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
         if(this.FNextTimeID != 0)
         {
            clearTimeout(this.FNextTimeID);
            this.FNextTimeID = 0;
         }
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
         this.FUnstreamizerCloudBuy.Unstreamize(_loc2_,this.FCloudBuy,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.SetEndTime();
            this.UpdateUI();
            this.FNextNewsTime = STimingCore.GetServerTick() + 5;
            this.SetNextNewsTime();
         }
      }
      
      override public function ProcessorOnLoadNewsRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:String = null;
         _loc2_ = param1.Data;
         TweenUtil.removeAllTween();
         this.FLogIndex = 0;
         this.FCloudBuy.NewsList.length = 0;
         _loc5_ = _loc2_.readShort();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc7_ = TUtilityString.FetchUTF(_loc2_);
            _loc6_ = TUtilityString.Format(this.FCloudBuy.DescListNew[6],_loc7_);
            this.FCloudBuy.NewsList[_loc4_] = _loc6_;
            _loc4_++;
         }
         this.FNextNewsTime = STimingCore.GetServerTick() + LOAD_NEWS_TIME;
         this.SetNextNewsTime();
         this.PlayNews();
      }
      
      public function PlayNews() : void
      {
         if(this.FLogIndex >= this.FCloudBuy.NewsList.length)
         {
            FMC_Scene.MC_News.MC_News.TF_Text.text = "";
            return;
         }
         FMC_Scene.MC_News.visible = true;
         FMC_Scene.MC_News.MC_News.x = this.FEndX;
         FMC_Scene.MC_News.MC_News.TF_Text.text = this.FCloudBuy.NewsList[this.FLogIndex];
         TweenUtil.to(FMC_Scene.MC_News.MC_News,8000,{
            "x":this.FInitX,
            "onComplete":this.EndTween
         });
      }
      
      public function EndTween() : void
      {
         ++this.FLogIndex;
         this.PlayNews();
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
            case REQ_TYPE_BUY:
               ++this.FCloudBuy.MyCount;
               ++this.FCloudBuy.BoughtCount;
               this.FCloudBuy.RemainCount = _loc2_.readUnsignedInt();
               _loc4_ = STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED;
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FCloudBuy.CheckStatus());
               this.UpdateUI();
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
         _loc3_.writeUnsignedInt(STimingCore.GetServerTick() + 100);
         _loc3_.writeShort(7);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"价值%0金币");
         TUtilityString.FlushUTF(_loc3_,"揭晓时间");
         TUtilityString.FlushUTF(_loc3_,"下期开始时间");
         TUtilityString.FlushUTF(_loc3_,"购买按钮TIPS");
         TUtilityString.FlushUTF(_loc3_,"%0购买了一份");
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(2);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(0);
         TUtilityString.FlushUTF(_loc3_,"xxxxx");
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeInt(3);
            _loc3_.writeInt(0);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100002 + _loc1_);
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            TUtilityString.FlushUTF(_loc3_,"Index" + _loc1_);
            _loc3_.writeInt(1401571200 + _loc1_ * 100);
            _loc3_.writeShort(1);
            _loc3_.writeInt(3);
            _loc3_.writeInt(0);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100002 + _loc1_);
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

