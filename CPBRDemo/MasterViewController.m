//
//  MasterViewController.m
//  CPBRDemo
//
//  Created by Rafael Winter on 29/01/13.
//  Copyright (c) 2013 Rafael Winter. All rights reserved.
//

#import "MasterViewController.h"

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Cria o botão recarregar, usando um estilo de sistema e vinculando o botão ao método reloadTweets
    UIBarButtonItem *reloadButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadTweets:)];
    
    // Adiciona o novo botão no lado direito da barra de navegação
    self.navigationItem.rightBarButtonItem = reloadButton;
    
    // Muda o título da barra de navegação
    self.navigationItem.title = @"#CPBR6";
    
    // Cria a coleção de tweets que será usada como data source da table view
    self.tweetList = [[NSMutableArray alloc] init];
    
    // Força a primeira carga de tweets
    [self loadCPBR6Tweets];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Nossa table view possui apenas uma seção
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // O número de linhas da tabela é a quantidade de itens da coleção de tweets
    return [self.tweetList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Cria um objeto célula
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    // Seleciona o dicionário da coleção de tweets relacionado a esta célula
    NSDictionary *object = [self.tweetList objectAtIndex:indexPath.row];
    
    // Carrega os dados na célula
    cell.textLabel.text = [object objectForKey:@"user"];
    cell.detailTextLabel.text = [object objectForKey:@"text"];
    
    return cell;
}

// Ação do botão recarregar
- (void)reloadTweets:(id)sender {
    NSLog(@"reload!!!");
    
    [self loadCPBR6Tweets];
}

#pragma mark - Tweets

// Carrega a lista de tweets mais recentes com a hashtag #CPBR6
- (void)loadCPBR6Tweets {
    
    // Monta a URL de busca
    NSURL *searchUrl = [NSURL URLWithString:@"https://search.twitter.com/search.json?q=%23CPBR6"];
    
    // Carrega o resultado da busca
    NSData *searchRawData = [NSData dataWithContentsOfURL:searchUrl];
    
    // Decodifica o JSON do resultado em um dicionário
    NSError *decodingError = nil;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:searchRawData
                                                           options:kNilOptions
                                                             error:&decodingError];
    
    if (decodingError) {
        
        // Imprime uma mensagem de debug no console
        NSLog(@"Deu erro ao decodificar o JSON do twitter. #chatiado #cpbr6");
        
    } else {
        
        // Limpa a coleção de tweets
        [self.tweetList removeAllObjects];
        
        // Processa todos tweets do resultado de busca
        NSArray *tweets = [result objectForKey:@"results"];
        for (NSDictionary *tweet in tweets) {
            
            NSString *user = [NSString stringWithFormat:@"@%@", [tweet objectForKey:@"from_user"]];
            NSString *text = [tweet objectForKey:@"text"];
            
            // Cria um dicionário contendo o user e o tweet. Esse dicionário
            // posteriormente é carregado na hora de popular a table view
            NSDictionary *tweetForList = [NSDictionary dictionaryWithObjectsAndKeys:user, @"user", text, @"text", nil];

            // Adiciona esse dicionário na coleção de tweets
            [self.tweetList addObject:tweetForList];

            // Imprime o tweet no console de debug
            NSLog(@"user: %@ tweet: \"%@\"", user, text);
            
        }
        
        // Força a recarga do table view
        [self.tableView reloadData];
    }
    
}


@end
