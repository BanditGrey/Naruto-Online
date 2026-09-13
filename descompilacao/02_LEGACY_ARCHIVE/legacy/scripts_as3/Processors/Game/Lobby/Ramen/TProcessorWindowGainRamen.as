package Processors.Game.Lobby.Ramen
{
   import Components.Pages.TUIPage;
   import Foundation.Common.THint;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TFriendDigest;
   import Logics.Characters.TFriendDigests;
   import Logics.Ramn.TFriendRamenData;
   import Logics.SLogicsCore;
   import Logics.Vip.TVip;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_RAMEN;
   import Resources.Strings.STRING_Ramen;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowGainRamen extends TProcessorLobbyWindow
   {
      
      protected static const MAX_COUNT:uint = 12;
      
      protected var FScene:Sprite;
      
      protected var FMC_Clan:MovieClip;
      
      protected var FBtn_MaterialFilterSelected:SimpleButton;
      
      protected var FBtn_MaterialFilterUnSelected:SimpleButton;
      
      protected var FMC_BatchSend:MovieClip;
      
      protected var FMC_Page:TUIPage;
      
      protected var FFriendRamen:Vector.<TFriendRamenData>;
      
      protected var FFilterFriendRamen:Vector.<TFriendRamenData>;
      
      protected var FFriendDatas:TFriendDigests;
      
      protected var FFriendUIList:Vector.<TUIFriendsList>;
      
      protected var FFriendBGList:Vector.<MovieClip>;
      
      protected var FPageIndex:uint;
      
      protected var FSelectFriendData:TFriendRamenData;
      
      protected var FVipData:TVip;
      
      protected var FHint:THint;
      
      protected var FIsFilter:Boolean;
      
      protected var FSelectFriend:Function;
      
      protected var FBatchSend:Function;
      
      protected var FOnHintOnOver:Function;
      
      protected var FOnHintOnOut:Function;
      
      public function TProcessorWindowGainRamen(param1:TUIComponent)
      {
         super(param1);
         this.FFriendRamen = SLogicsCore.RamenData.FriendsRamen;
         this.FFriendDatas = SLogicsCore.Friends;
         this.FVipData = SLogicsCore.Character.VipData;
         this.FFilterFriendRamen = new Vector.<TFriendRamenData>();
         this.FHint = new THint();
      }
      
      protected function ResourcesPerform_Dispatch(param1:MovieClip) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TUIFriendsList = null;
         var _loc4_:MovieClip = null;
         this.FScene = param1;
         this.FScene[CONST_RAMEN.RESOURCE_Link_MC_Right].play();
         this.FFriendUIList = new Vector.<TUIFriendsList>();
         this.FFriendBGList = new Vector.<MovieClip>();
         _loc2_ = 0;
         while(_loc2_ < MAX_COUNT)
         {
            _loc4_ = this.FScene[CONST_RAMEN.RESOURCE_Link_MC_Friend + _loc2_];
            _loc3_ = new TUIFriendsList(this);
            _loc3_.ResourcesUIDispatch(_loc4_);
            _loc3_.SelectFriend = this.OnSelectFriend;
            this.FFriendUIList.push(_loc3_);
            this.FFriendBGList.push(this.FScene[CONST_RAMEN.RESOURCE_Link_MC_Shades + _loc2_]);
            _loc4_.addEventListener(MouseEvent.ROLL_OVER,this.OnMouseRoll);
            _loc4_.addEventListener(MouseEvent.ROLL_OUT,this.OnMouseRoll);
            _loc2_++;
         }
         this.FMC_Clan = this.FScene[CONST_RAMEN.RESOURCE_Link_MC_Clan];
         this.FBtn_MaterialFilterSelected = this.FMC_Clan[CONST_RAMEN.RESOURCE_Link_Btn_MaterialFilterSelected];
         this.FBtn_MaterialFilterUnSelected = this.FMC_Clan[CONST_RAMEN.RESOURCE_Link_Btn_MaterialFilterUnSelected];
         this.FMC_BatchSend = this.FScene[CONST_RAMEN.RESOURCE_Link_MC_BatchSend];
         this.FBtn_MaterialFilterSelected.visible = false;
         this.FMC_Page = new TUIPage(this);
         this.FMC_Page.ButtonPrevious.Substrate = this.FScene[CONST_RAMEN.RESOURCE_Link_MC_PageLeft];
         this.FMC_Page.ButtonNext.Substrate = this.FScene[CONST_RAMEN.RESOURCE_Link_MC_PageRight];
         this.FMC_Page.LabelPage = this.FScene[CONST_RAMEN.RESOURCE_Link_TF_Page];
         this.FMC_Page.PageSize = MAX_COUNT;
         this.FMC_Page.Init();
         this.ResourcesPerform_Locations();
      }
      
      protected function ResourcesPerform_Locations() : void
      {
         this.FMC_Page.OnChangePage = this.PageOnChange;
         TGameUtil.setButtonMode(this.FMC_BatchSend,true);
         this.FMC_BatchSend.addEventListener(MouseEvent.CLICK,this.OnBatchSend);
         this.FMC_BatchSend.addEventListener(MouseEvent.MOUSE_MOVE,this.OnBatchSendRoll);
         this.FMC_BatchSend.addEventListener(MouseEvent.ROLL_OUT,this.OnBatchSendRoll);
         this.FBtn_MaterialFilterSelected.addEventListener(MouseEvent.CLICK,this.OnFilterSelected);
         this.FBtn_MaterialFilterUnSelected.addEventListener(MouseEvent.CLICK,this.OnFilterSelected);
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateFriends() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TUIFriendsList = null;
         var _loc3_:uint = 0;
         var _loc4_:TFriendDigest = null;
         var _loc5_:TFriendRamenData = null;
         var _loc6_:TUIFriendsList = null;
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc3_ = _loc1_ + this.FPageIndex * MAX_COUNT;
            _loc6_ = this.FFriendUIList[_loc1_];
            if(_loc3_ < this.FFilterFriendRamen.length)
            {
               _loc6_.Visible = true;
               _loc6_.Visible = true;
               _loc5_ = this.FFilterFriendRamen[_loc3_];
               _loc4_ = this.FFriendDatas.GetDigestByIdentifier(_loc5_.Identifier0,_loc5_.Identifier1);
               _loc6_.SetFriendData(_loc5_,_loc4_);
            }
            else
            {
               _loc6_.Visible = false;
               _loc6_.Visible = false;
            }
            _loc6_.IsSelect(this.FSelectFriendData == _loc6_.FriendData);
            _loc1_++;
         }
         TGameUtil.setButtonMode(this.FMC_BatchSend,this.FVipData.OneWater);
         this.FHint.Caption = TUtilityString.Format(STRING_Ramen.STRING_OpenOneWaterVipLevel,SLogicsCore.Character.VipData.VipOpenLevel_OneWater);
      }
      
      protected function OnSetFilter(param1:Boolean) : void
      {
         this.FIsFilter = param1;
         this.FBtn_MaterialFilterSelected.visible = param1;
         this.FBtn_MaterialFilterUnSelected.visible = !param1;
      }
      
      protected function FilterFriends() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:TFriendRamenData = null;
         var _loc3_:TFriendDigest = null;
         var _loc4_:uint = 0;
         _loc4_ = uint(SLogicsCore.Character.Country);
         this.FFilterFriendRamen.length = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FFriendRamen.length)
         {
            _loc2_ = this.FFriendRamen[_loc1_];
            if(this.FIsFilter)
            {
               _loc3_ = this.FFriendDatas.GetDigestByIdentifier(_loc2_.Identifier0,_loc2_.Identifier1);
               if(_loc3_.Country == SLogicsCore.Character.Country)
               {
                  this.FFilterFriendRamen.push(_loc2_);
               }
            }
            else
            {
               this.FFilterFriendRamen.push(_loc2_);
            }
            _loc1_++;
         }
         this.FPageIndex = 0;
         this.FMC_Page.TotalQuantity = this.FFilterFriendRamen.length;
         this.FMC_Page.PageIndex = this.FPageIndex;
         this.FMC_Page.Update();
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         if(param2 == this.FPageIndex)
         {
            return;
         }
         this.FPageIndex = param2;
         this.UpdateFriends();
      }
      
      protected function OnBatchSend(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TFriendRamenData = null;
         var _loc5_:Vector.<uint> = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc5_ = new Vector.<uint>();
         _loc2_ = 0;
         while(_loc2_ < this.FFilterFriendRamen.length)
         {
            _loc4_ = this.FFilterFriendRamen[_loc2_];
            if(_loc4_.FriendRamenSendGoodsCount <= 0)
            {
               _loc5_.push(_loc4_.Identifier0,_loc4_.Identifier1);
            }
            _loc2_++;
         }
         if(_loc5_.length <= 0)
         {
            EffectGenerateText(STRING_Ramen.STRING_NoFriendNeedGoods);
            return;
         }
         if(this.FBatchSend != null)
         {
            this.FBatchSend(this,_loc5_);
         }
      }
      
      protected function OnBatchSendRoll(param1:MouseEvent) : void
      {
         if(param1.currentTarget.buttonMode)
         {
            return;
         }
         if(param1.type == MouseEvent.MOUSE_MOVE)
         {
            if(this.FOnHintOnOver != null)
            {
               this.FOnHintOnOver(this,this.FHint);
            }
         }
         else if(param1.type == MouseEvent.ROLL_OUT)
         {
            if(this.FOnHintOnOut != null)
            {
               this.FOnHintOnOut(this);
            }
         }
      }
      
      protected function OnFilterSelected(param1:MouseEvent) : void
      {
         if(param1.target == this.FBtn_MaterialFilterSelected)
         {
            this.OnSetFilter(false);
         }
         else if(param1.target == this.FBtn_MaterialFilterUnSelected)
         {
            this.OnSetFilter(true);
         }
         this.FilterFriends();
         this.UpdateFriends();
      }
      
      protected function OnSelectFriend(param1:Object, param2:TFriendRamenData) : void
      {
         if(this.FSelectFriend != null)
         {
            this.FSelectFriend(param1,param2);
         }
         this.FSelectFriendData = param2;
         this.UpdateFriends();
      }
      
      protected function OnMouseRoll(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = uint(int(String(param1.currentTarget.name).slice(10)));
         if(param1.type == MouseEvent.ROLL_OVER)
         {
            this.FFriendBGList[_loc2_].gotoAndStop(2);
         }
         else if(param1.type == MouseEvent.ROLL_OUT)
         {
            this.FFriendBGList[_loc2_].gotoAndStop(1);
         }
      }
      
      public function get SelectFriend() : Function
      {
         return this.FSelectFriend;
      }
      
      public function set SelectFriend(param1:Function) : void
      {
         this.FSelectFriend = param1;
      }
      
      public function get BatchSend() : Function
      {
         return this.FBatchSend;
      }
      
      public function set BatchSend(param1:Function) : void
      {
         this.FBatchSend = param1;
      }
      
      public function get OnHintOnOver() : Function
      {
         return this.FOnHintOnOver;
      }
      
      public function set OnHintOnOver(param1:Function) : void
      {
         this.FOnHintOnOver = param1;
      }
      
      public function get OnHintOnOut() : Function
      {
         return this.FOnHintOnOut;
      }
      
      public function set OnHintOnOut(param1:Function) : void
      {
         this.FOnHintOnOut = param1;
      }
      
      public function ResourcesPerformDispatch(param1:MovieClip) : void
      {
         this.ResourcesPerform_Dispatch(param1);
      }
      
      public function ResetFriend() : void
      {
         this.OnSetFilter(false);
         this.FilterFriends();
         this.FSelectFriendData = null;
         this.UpdateFriends();
      }
      
      public function UpdataUI() : void
      {
         this.UpdateFriends();
      }
      
      public function ReturnMyShop() : void
      {
         this.FSelectFriendData = null;
         this.UpdateFriends();
      }
      
      public function SendFriendGoods() : void
      {
         var _loc1_:Vector.<uint> = null;
         if(this.FSelectFriendData == null)
         {
            return;
         }
         _loc1_ = new Vector.<uint>();
         _loc1_.push(this.FSelectFriendData.Identifier0);
         _loc1_.push(this.FSelectFriendData.Identifier1);
         if(this.FBatchSend != null)
         {
            this.FBatchSend(this,_loc1_);
         }
      }
   }
}

