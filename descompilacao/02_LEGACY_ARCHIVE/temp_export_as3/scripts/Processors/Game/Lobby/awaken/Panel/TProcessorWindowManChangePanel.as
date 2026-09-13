package Processors.Game.Lobby.awaken.Panel
{
   import Components.Slots.TUISlot;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.awaken.date.AwakenDateCELL;
   import Processors.Game.Lobby.awaken.date.AwakenLogicDate;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_AWAKEN;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_AWAKEN;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowManChangePanel extends TProcessorGame
   {
      
      public static const Three:int = 3;
      
      protected var FThisPanel:Sprite = null;
      
      protected var FMcItemVec:Vector.<MovieClip> = null;
      
      protected var FTF_Num:TextField = null;
      
      protected var FAwakenDatas:AwakenLogicDate = null;
      
      protected var ThreeSlot:Vector.<TUISlot>;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FSelectInventories:TInventories;
      
      protected var FTempSelectInventoriesId:Vector.<uint>;
      
      protected var FSlotsOnMove:Function;
      
      protected var FSlotsOnOut:Function;
      
      protected var FCloseFunction:Function = null;
      
      protected var FBackFun:Function = null;
      
      public function TProcessorWindowManChangePanel(param1:TUIComponent)
      {
         super(param1);
         this.FMcItemVec = new Vector.<MovieClip>(Three);
         this.ThreeSlot = new Vector.<TUISlot>(Three);
         this.FAwakenDatas = SLogicsCore.AwakenDate;
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FSelectInventories = new TInventories();
         this.FTempSelectInventoriesId = new Vector.<uint>();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_AWAKEN.ResourceId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_ChangeFragment") as Sprite;
         this.addChild(this.FThisPanel);
         this.x = (FUICore.StageWidth - this.width) / 2;
         this.y = (FUICore.StageHeight - this.height) / 2;
         this.FTF_Num = this.FThisPanel["TF_Num"];
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc3_:int = 0;
         var _loc4_:TextField = null;
         var _loc5_:TInventory = null;
         this.AddEventlistener();
         var _loc1_:AwakenDateCELL = new AwakenDateCELL();
         var _loc2_:TUISlot = null;
         _loc1_.SetValueById(this.FAwakenDatas.SuiPianId);
         _loc3_ = 0;
         while(_loc3_ < this.FMcItemVec.length)
         {
            _loc4_ = this.FMcItemVec[_loc3_]["TF_NeedDec"];
            _loc4_.text = TUtilityString.Format(STRING_AWAKEN.Str2,SLogicsCore.AwakenDate.ChangeCountVec[_loc3_]);
            _loc2_ = this.GetSlotCell();
            _loc2_.Resource = this.FMcItemVec[_loc3_]["MC_Slot"];
            _loc2_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc2_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc2_.Init();
            _loc2_.OnOverlay = this.FSlotsOnMove;
            _loc2_.OnOut = this.FSlotsOnOut;
            this.ThreeSlot[_loc3_] = _loc2_;
            _loc3_++;
         }
         this.FSelectInventories.Clear();
         this.FTempSelectInventoriesId.length = 0;
         _loc3_ = 0;
         while(_loc3_ < Three)
         {
            this.FTempSelectInventoriesId.push(SLogicsCore.AwakenDate.GetArrByType(_loc3_)[0]);
            _loc3_++;
         }
         this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FSelectInventories,this.FTempSelectInventoriesId);
         _loc3_ = 0;
         while(_loc3_ < Three)
         {
            _loc5_ = this.FSelectInventories.GetInventoryByIndex(_loc3_);
            this.ThreeSlot[_loc3_].Context = _loc5_;
            _loc4_ = this.FMcItemVec[_loc3_]["TF_Name"];
            _loc4_.text = _loc5_.Name;
            _loc4_.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[_loc5_.Quality];
            _loc3_++;
         }
         super.ResourcesPerform_UILocations();
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TInventory;
         _loc6_ = SResourcesCore.TexturesInventory;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Awaken);
         }
      }
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TAppliance = null;
         if(param2 is TAppliance)
         {
            _loc4_ = param2 as TAppliance;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
      
      public function LogicPerform() : void
      {
         super.LogicsPerform();
      }
      
      protected function AddEventlistener() : void
      {
         SimpleButton(this.FThisPanel["btn_Close"]).addEventListener(MouseEvent.CLICK,this.HandleClick);
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this.FMcItemVec[_loc1_] = this.FThisPanel["MC_Item_" + _loc1_];
            this.FMcItemVec[_loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.HandleOver);
            this.FMcItemVec[_loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.HandleOut);
            MovieClip(this.FMcItemVec[_loc1_]["MC_ChangeBtn"]).addEventListener(MouseEvent.CLICK,this.HandleClick);
            _loc1_++;
         }
         super.LogicsPerform();
      }
      
      protected function GetSlotCell() : TUISlot
      {
         var _loc1_:TUISlot = null;
         _loc1_ = new TUISlot(Parent);
         _loc1_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         return _loc1_;
      }
      
      protected function HandleOver(param1:MouseEvent) : void
      {
         MovieClip(param1.currentTarget).gotoAndStop(2);
      }
      
      protected function HandleOut(param1:MouseEvent) : void
      {
         MovieClip(param1.currentTarget).gotoAndStop(1);
      }
      
      protected function HandleClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FThisPanel["btn_Close"]:
               this.visible = false;
               break;
            case this.FMcItemVec[0]["MC_ChangeBtn"]:
               if(this.FBackFun != null && MovieClip(this.FMcItemVec[0]["MC_ChangeBtn"]).buttonMode)
               {
                  this.FBackFun(1);
               }
               break;
            case this.FMcItemVec[1]["MC_ChangeBtn"]:
               if(this.FBackFun != null && MovieClip(this.FMcItemVec[1]["MC_ChangeBtn"]).buttonMode)
               {
                  this.FBackFun(2);
               }
               break;
            case this.FMcItemVec[2]["MC_ChangeBtn"]:
               if(this.FBackFun != null && MovieClip(this.FMcItemVec[2]["MC_ChangeBtn"]).buttonMode)
               {
                  this.FBackFun(3);
               }
         }
      }
      
      public function UpdateImage() : void
      {
         if(!this.visible)
         {
            return;
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.ThreeSlot.length)
         {
            this.ThreeSlot[_loc1_].Update();
            _loc1_++;
         }
      }
      
      public function UpdateView() : void
      {
         var _loc1_:int = this.FAwakenDatas.GetCountById(this.FAwakenDatas.SuiPianId);
         this.FTF_Num.text = _loc1_.toString();
         var _loc2_:int = 0;
         while(_loc2_ < this.FMcItemVec.length)
         {
            TextField(this.FMcItemVec[_loc2_]["TF_Count_nimei"]).text = SLogicsCore.AwakenDate.GetDaoJuCountAtBeiBaoByType(_loc2_).toString();
            if(_loc1_ >= SLogicsCore.AwakenDate.ChangeCountVec[_loc2_])
            {
               TGameUtil.setButtonMode(this.FMcItemVec[_loc2_]["MC_ChangeBtn"],true);
            }
            else
            {
               TGameUtil.setButtonMode(this.FMcItemVec[_loc2_]["MC_ChangeBtn"],false);
            }
            _loc2_++;
         }
      }
      
      public function set BackFun(param1:Function) : void
      {
         this.FBackFun = param1;
      }
      
      public function get SlotsOnMove() : Function
      {
         return this.FSlotsOnMove;
      }
      
      public function set SlotsOnMove(param1:Function) : void
      {
         this.FSlotsOnMove = param1;
      }
      
      public function get SlotsOnOut() : Function
      {
         return this.FSlotsOnOut;
      }
      
      public function set SlotsOnOut(param1:Function) : void
      {
         this.FSlotsOnOut = param1;
      }
   }
}

