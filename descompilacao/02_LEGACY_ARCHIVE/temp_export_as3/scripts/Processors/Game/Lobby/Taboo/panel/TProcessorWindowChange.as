package Processors.Game.Lobby.Taboo.panel
{
   import Components.Slots.TUISlotCopy;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TTabooBattle;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Taboo.Cell.GuanQiaCell;
   import Processors.Game.Lobby.Taboo.Data.TabooDataCell;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_TABOO;
   import Resources.Strings.STRING_TABOO;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowChange extends TProcessorLobbyWindow
   {
      
      public static const SIX:int = 15;
      
      public static const THREE:int = 3;
      
      protected var MainPanel:Sprite = null;
      
      protected var FMC_SureBtn:MovieClip = null;
      
      protected var FMC_CancenBtn:MovieClip = null;
      
      protected var FIsInilization:Boolean;
      
      protected var SlostVect:Vector.<TUISlotCopy> = null;
      
      protected var MCVec:Vector.<MovieClip> = null;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FSelectInventories:TInventories;
      
      protected var FTempSelectInventoriesId:Vector.<uint>;
      
      protected var FInventoriesCount:Vector.<uint>;
      
      protected var FVecTabooCell:Vector.<TabooDataCell>;
      
      protected var FTF_LieBiao:TextField;
      
      protected var DataVec:Vector.<TTabooBattle> = null;
      
      protected var FSlotsOnMove:Function;
      
      protected var FSlotsOnOut:Function;
      
      protected var FBtnBackFun:Function;
      
      public function TProcessorWindowChange(param1:TUIComponent)
      {
         super(param1);
         this.SlostVect = new Vector.<TUISlotCopy>(SIX);
         this.FTempSelectInventoriesId = new Vector.<uint>();
         this.FInventoriesCount = new Vector.<uint>();
         this.FSelectInventories = new TInventories();
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FVecTabooCell = new Vector.<TabooDataCell>();
         this.MCVec = new Vector.<MovieClip>(THREE);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TABOO.ResourceId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(-(FUICore.StageWidth / 2),-(FUICore.StageHeight / 2),FUICore.StageWidth * 2,FUICore.StageHeight * 2);
         this.graphics.endFill();
         this.MainPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_TABOO.MC_Change) as Sprite;
         addChild(this.MainPanel);
         this.MainPanel.x = (FUICore.StageWidth - this.MainPanel.width) / 2;
         this.MainPanel.y = (FUICore.StageHeight - this.MainPanel.height) / 2;
         this.FTF_LieBiao = this.MainPanel["TF_LieBiao"];
         _loc1_ = 0;
         while(_loc1_ < SIX)
         {
            this.SlostVect[_loc1_] = new TUISlotCopy(this,CONST_MODULES.MODULE_Taboo);
            this.SlostVect[_loc1_].MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            this.SlostVect[_loc1_].OnOverlay = this.FSlotsOnMove;
            this.SlostVect[_loc1_].OnOut = this.FSlotsOnOut;
            this.SlostVect[_loc1_].OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            this.SlostVect[_loc1_].OnQuerySubscript = this.SlotsOnQuerySubscript;
            this.SlostVect[_loc1_].Resource = this.MainPanel["MC_Slot_" + _loc1_];
            this.SlostVect[_loc1_].Init();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < THREE)
         {
            this.MCVec[_loc1_] = this.MainPanel["MC_Nandu_" + _loc1_];
            MovieClip(this.MCVec[_loc1_]["MC_Task"]).addEventListener(MouseEvent.CLICK,this.TaskClick);
            TextField(this.MCVec[_loc1_]["MC_NanduName"]).text = STRING_TABOO.Str7[_loc1_];
            _loc1_++;
         }
         this.FMC_SureBtn = this.MainPanel["MC_SureBtn"];
         this.FMC_CancenBtn = this.MainPanel["MC_CancenBtn"];
         TGameUtil.setButtonMode(this.FMC_SureBtn,true);
         TGameUtil.setButtonMode(this.FMC_CancenBtn,true);
         this.FMC_SureBtn.addEventListener(MouseEvent.CLICK,this.BtnClick);
         this.FMC_CancenBtn.addEventListener(MouseEvent.CLICK,this.BtnClick);
         this.FIsInilization = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      public function SetDate(param1:Vector.<TTabooBattle>) : void
      {
         this.DataVec = param1;
      }
      
      public function OpenThisPanel() : void
      {
         this.SetState();
         this.UpdateBeefOffal();
      }
      
      public function UpdateBeefOffal() : void
      {
         var _loc2_:int = 0;
         var _loc1_:GuanQiaCell = null;
         _loc2_ = 0;
         while(_loc2_ < THREE)
         {
            _loc1_ = SLogicsCore.TBooData.GetGuanQiaCellByConfig(this.DataVec[_loc2_]);
            if(_loc1_)
            {
               MovieClip(this.MCVec[_loc2_]["MC_TongGuanLabel"]).visible = true;
            }
            else
            {
               MovieClip(this.MCVec[_loc2_]["MC_TongGuanLabel"]).visible = false;
            }
            _loc2_++;
         }
      }
      
      protected function BtnClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_SureBtn:
               this.FBtnBackFun(this.DataVec[0].CurNanDu);
               break;
            case this.FMC_CancenBtn:
               this.FBtnBackFun(0);
         }
         this.visible = false;
      }
      
      protected function TaskClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.MCVec[0]["MC_Task"]:
               this.DataVec[0].CurNanDu = 0;
               break;
            case this.MCVec[1]["MC_Task"]:
               this.DataVec[0].CurNanDu = 1;
               break;
            case this.MCVec[2]["MC_Task"]:
               this.DataVec[0].CurNanDu = 2;
         }
         this.SetState();
      }
      
      protected function SetState() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < THREE)
         {
            MovieClip(this.MCVec[_loc1_]["MC_Task"]).gotoAndStop(1);
            _loc1_++;
         }
         switch(this.DataVec[0].CurNanDu)
         {
            case 0:
               MovieClip(this.MCVec[0]["MC_Task"]).gotoAndStop(2);
               break;
            case 1:
               MovieClip(this.MCVec[1]["MC_Task"]).gotoAndStop(2);
               break;
            case 2:
               MovieClip(this.MCVec[2]["MC_Task"]).gotoAndStop(2);
         }
         this.UpdateStuff();
         this.FTF_LieBiao.text = TUtilityString.Format(STRING_TABOO.Str25,this.DataVec[this.DataVec[0].CurNanDu].Name);
      }
      
      public function UpdateStuff() : void
      {
         var _loc1_:int = 0;
         this.FTempSelectInventoriesId.length = 0;
         this.FInventoriesCount.length = 0;
         this.FSelectInventories.Clear();
         this.FVecTabooCell.length = 0;
         var _loc2_:TabooDataCell = null;
         _loc1_ = 0;
         while(_loc1_ < this.DataVec[this.DataVec[0].CurNanDu].GaoJiRewardsVect.length)
         {
            if(this.DataVec[this.DataVec[0].CurNanDu].GaoJiRewardsVect[_loc1_].Type == 18)
            {
               _loc2_ = new TabooDataCell();
               _loc2_.SetValueById(this.DataVec[this.DataVec[0].CurNanDu].GaoJiRewardsVect[_loc1_].Code);
               _loc2_.Count = this.DataVec[this.DataVec[0].CurNanDu].GaoJiRewardsVect[_loc1_].Amount;
               this.FVecTabooCell.push(_loc2_);
            }
            else
            {
               this.FTempSelectInventoriesId.push(this.DataVec[this.DataVec[0].CurNanDu].GaoJiRewardsVect[_loc1_].Code);
               this.FInventoriesCount.push(this.DataVec[this.DataVec[0].CurNanDu].GaoJiRewardsVect[_loc1_].Amount);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.DataVec[this.DataVec[0].CurNanDu].GeneralRewardsVect.length)
         {
            if(this.DataVec[this.DataVec[0].CurNanDu].GeneralRewardsVect[_loc1_].Type == 18)
            {
               _loc2_ = new TabooDataCell();
               _loc2_.SetValueById(this.DataVec[this.DataVec[0].CurNanDu].GeneralRewardsVect[_loc1_].Code);
               _loc2_.Count = this.DataVec[this.DataVec[0].CurNanDu].GeneralRewardsVect[_loc1_].Amount;
               this.FVecTabooCell.push(_loc2_);
            }
            else
            {
               this.FTempSelectInventoriesId.push(this.DataVec[this.DataVec[0].CurNanDu].GeneralRewardsVect[_loc1_].Code);
               this.FInventoriesCount.push(this.DataVec[this.DataVec[0].CurNanDu].GeneralRewardsVect[_loc1_].Amount);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.DataVec[this.DataVec[0].CurNanDu].PieceRewardsVect.length)
         {
            if(this.DataVec[this.DataVec[0].CurNanDu].PieceRewardsVect[_loc1_].Type == 18)
            {
               _loc2_ = new TabooDataCell();
               _loc2_.SetValueById(this.DataVec[this.DataVec[0].CurNanDu].PieceRewardsVect[_loc1_].Code);
               _loc2_.Count = this.DataVec[this.DataVec[0].CurNanDu].PieceRewardsVect[_loc1_].Amount;
               this.FVecTabooCell.push(_loc2_);
            }
            else
            {
               this.FTempSelectInventoriesId.push(this.DataVec[this.DataVec[0].CurNanDu].PieceRewardsVect[_loc1_].Code);
               this.FInventoriesCount.push(this.DataVec[this.DataVec[0].CurNanDu].PieceRewardsVect[_loc1_].Amount);
            }
            _loc1_++;
         }
         this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FSelectInventories,this.FTempSelectInventoriesId);
         _loc1_ = 0;
         while(_loc1_ < this.FSelectInventories.Count)
         {
            this.FSelectInventories.GetInventoryByIndex(_loc1_).Quantity = this.FInventoriesCount[_loc1_];
            _loc1_++;
         }
         this.UpdateSlot();
      }
      
      protected function UpdateSlot() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < SIX)
         {
            if(_loc1_ < this.FSelectInventories.Count + this.FVecTabooCell.length)
            {
               if(_loc1_ >= this.FSelectInventories.Count)
               {
                  this.SlostVect[_loc1_].Context = this.FVecTabooCell[_loc1_ - this.FSelectInventories.Count];
               }
               else
               {
                  this.SlostVect[_loc1_].Context = this.FSelectInventories.GetInventoryByIndex(_loc1_);
               }
            }
            else
            {
               this.SlostVect[_loc1_].Context = null;
            }
            _loc1_++;
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(this.visible)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FSelectInventories.Count + this.FVecTabooCell.length)
            {
               this.SlostVect[_loc1_].Update();
               _loc1_++;
            }
         }
         super.LogicsPerform();
      }
      
      public function set BtnBackFun(param1:Function) : void
      {
         this.FBtnBackFun = param1;
      }
      
      public function set SlotsOnMove(param1:Function) : void
      {
         this.FSlotsOnMove = param1;
      }
      
      public function set SlotsOnOut(param1:Function) : void
      {
         this.FSlotsOnOut = param1;
      }
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TInventory = null;
         var _loc5_:TabooDataCell = null;
         if(param2 is TabooDataCell)
         {
            _loc5_ = param2 as TabooDataCell;
            param3.Value = _loc5_.Count.toString();
         }
         else
         {
            _loc4_ = param2 as TInventory;
            param3.Value = _loc4_.Quantity.toString();
         }
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Taboo);
         }
      }
   }
}

